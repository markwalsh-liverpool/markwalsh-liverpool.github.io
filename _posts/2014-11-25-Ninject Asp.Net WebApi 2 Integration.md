---
layout: post
category : development
tagline: 
tags : [development, c#, ninject]
title : Ninject ASP.Net WebApi 2 Integration
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

After much research, it doesn't appear people use Ninject here...or they don't document it...anyway, I decided to add a method to get the created kernel from the NinjectWebCommon class called **GetKernel**.  Please note that this snippet also includes the declaration for a NinjectDependencyResolver.

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
        	// Getting the kernel via the exposed method
            var kernel = NinjectWebCommon.GetKernel();

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute("DefaultApi", "api/{controller}/{id}", new {id = RouteParameter.Optional}
                );

            // Manually injecting the bound instance
            config.Services.Replace(typeof (IExceptionHandler), kernel.Get<IExceptionHandler>());
        }
    }
{% endhighlight %}

If anyone has any better way to achieve the same results, please let me know in the comments!

<div class="callout callout-warning">
<strong>Update!</strong> I noticed after writing this tutorial, you don't have to add the ExceptionHandler to the services within the WebApiConfig class.  It's probably using reflection to check for any classes implementing IExceptionHandler and using that implementation.  Needless to say, there might still be instances where having the kernel in the WebApiConfig is neccessary so it's good to note the above method.
</div>
