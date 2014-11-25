---
layout: post
category : development
tagline: 
tags : [development, c#, ninject]
title : Ninject Asp.Net WebApi 2 Integration
---
{% include JB/setup %}

## Overview

I ran into a problem today where I needed to inject dependencies into a handler.  Typically, you don't really have access to the kernel here and I saw this as a problem as my handler had its own dependencies which needed to be resolved.

{% highlight csharp %}
	public class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute("DefaultApi", "api/{controller}/{id}", new {id = RouteParameter.Optional}
                );

            config.Services.Replace(typeof (IExceptionHandler), ***Err I need to be inject my concrete type here??**);
        }
    }
{% endhighlight %}

After much research, it doesn't appear people either use Ninject here or they don't document it...anyway, I decided to add a method to get the created kernel from the NinjectWebCommon class called **GetKernel**.  Please note that this snippet also includes the declaration for a NinjectDependencyResolver.

{% highlight csharp %}
    public static class NinjectWebCommon
    {
        private static readonly Bootstrapper Bootstrapper = new Bootstrapper();
        private static readonly IKernel _kernel = new StandardKernel();

        /// <summary>
        ///     Starts the application
        /// </summary>
        public static void Start()
        {
            DynamicModuleUtility.RegisterModule(typeof (OnePerRequestHttpModule));
            DynamicModuleUtility.RegisterModule(typeof (NinjectHttpModule));
            Bootstrapper.Initialize(CreateKernel);
        }

        /// <summary>
        ///     Stops the application.
        /// </summary>
        public static void Stop()
        {
            Bootstrapper.ShutDown();
        }

 		 /// <summary>
        ///     I added this method in order to get the kernel...
        /// </summary>
        public static IKernel GetKernel()
        {
            return _kernel;
        }

        /// <summary>
        ///     Creates the kernel that will manage your application.
        /// </summary>
        /// <returns>The created kernel.</returns>
        private static IKernel CreateKernel()
        {
            _kernel.Bind<Func<IKernel>>().ToMethod(ctx => () => new Bootstrapper().Kernel);
            _kernel.Bind<IHttpModule>().To<HttpApplicationInitializationHttpModule>();

            RegisterServices(_kernel);

            GlobalConfiguration.Configuration.DependencyResolver = new NinjectDependencyResolver(_kernel);

            return _kernel;
        }

        /// <summary>
        ///     Load your modules or register your services here!
        /// </summary>
        /// <param name="kernel">The kernel.</param>
        private static void RegisterServices(IKernel kernel)
        {
            kernel.Load(Assembly.GetExecutingAssembly());
        }
    }

    public class NinjectDependencyResolver : IDependencyResolver
    {
        private readonly IKernel _kernel;

        public NinjectDependencyResolver(IKernel kernel)
        {
            _kernel = kernel;
        }

        public object GetService(Type serviceType)
        {
            return _kernel.TryGet(serviceType);
        }

        public IEnumerable<object> GetServices(Type serviceType)
        {
            return _kernel.GetAll(serviceType);
        }

        public void Dispose()
        {
        }

        public IDependencyScope BeginScope()
        {
            return this;
        }
    }
{% endhighlight %}

Now I've exposed my kernel via this method I can then use it in the WebApiConfig class.  This doesn't seem ideal but there seems to be tons of different ways to configure Ninject dependant on the type of web project you're creating.

{% highlight csharp %}
  public class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            var kernel = NinjectWebCommon.GetKernel();

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute("DefaultApi", "api/{controller}/{id}", new {id = RouteParameter.Optional}
                );

            config.Services.Replace(typeof (IExceptionHandler), kernel.Get<IExceptionHandler>());
        }
    }
{% endhighlight %}

<div class="callout callout-warning">
<strong>Attention!</strong> If there's a better way of doing this, please let me know in the comments below
</div>