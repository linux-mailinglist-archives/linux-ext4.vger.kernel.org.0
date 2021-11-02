Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983C9442D50
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 12:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBMBl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBMBl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 08:01:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67EC061714
        for <linux-ext4@vger.kernel.org>; Tue,  2 Nov 2021 04:59:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s5so7760488pfg.2
        for <linux-ext4@vger.kernel.org>; Tue, 02 Nov 2021 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTlz4mPmSXJXulWaI3W7DyrjbcvRROyguUAu6VgIMcM=;
        b=HU0a4Q5E1sbrGT9zCp65mrv8jXTUfbqw3EyubLTXwcKbyDqO7AChG7CJfCGQlL1Cau
         yHHFg78Yh6/q2AqBQ2nirvOhgpaSnU4D0VNo04GfRzC7cb19R0lCLkfQFaPE+sDoK9dC
         NmK+nFdvwO5w5RgXaPn9daZeUMsCl3Bg9RqLJ2X4uKHlHgvhOKzPvN5nZY9VkHzzLeuo
         nAS4FBmW0Vt9z6qOkx+mPTHt/2aAm51JMUiSD5GjFoMgVgEurFYARB1aqbMaD3LZH0zW
         RoEyrgVjT/utjx/7+BdcPWqawmlFMlQifwQ6IpB6Vyoe63RR4bTPr7hgKUInIGY5D8nT
         R6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTlz4mPmSXJXulWaI3W7DyrjbcvRROyguUAu6VgIMcM=;
        b=fEZujm7eoco1KJI0ewBFMgDTBM8/x5GiwEidbIbJDhbFw+zEwKfOwf3GAMWO/sg+qv
         X6ewo3SDgROAo03m/6TjmpC1RiU0g0v+LKOYkecDppzr1UwcYkG2J6x6KGILza4OhAAU
         ir/whRsJS4RRaLvN91TRE3MmqS5x3PYUIx8eAgdpqtJ/JtG7NtEPrOQ3s8tM54vcv8fg
         cDjzxlrEKjjvCCxHrHZRf87u5roOqMqB4TAAW1N6NmtCFxeNrOuBf5KuVffCzDknro2a
         jMs1S62Su1IW3wx9ZAx3LVS02RTJWtibRBGws3s/ZRaUaL8Br/hDHyMFCXUqLtvoy+xz
         P7Bg==
X-Gm-Message-State: AOAM533IiPv5zFBRYE6hEPJq8pok4D0soO38h63OKUMIdRUKS2WDgjil
        XS+1IJZWUPuwuL3ZzEAPolIQDg==
X-Google-Smtp-Source: ABdhPJx8s94AcxtTQWn5+zdMWGa/RRM12ZAo7/b7NR5cDzmqs1KB42ofsUncXIece+KP49W5tRUmWw==
X-Received: by 2002:a63:954a:: with SMTP id t10mr27348586pgn.89.1635854345860;
        Tue, 02 Nov 2021 04:59:05 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com. [35.240.157.64])
        by smtp.gmail.com with ESMTPSA id n12sm15645895pgh.55.2021.11.02.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:59:05 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:58:58 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, ltp@lists.linux.it,
        khazhy@google.com, kernel@collabora.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 2/9] syscalls: fanotify: Add macro to require specific
 events
Message-ID: <YYEoAr743j3IO3ol@google.com>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-3-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 29, 2021 at 06:17:25PM -0300, Gabriel Krisman Bertazi wrote:
> Add a helper for tests to fail if an event is not available in the
> kernel.  Since some events only work with REPORT_FID or a specific
> class, update the verifier to allow those to be specified.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Made a single comment, otherwise this looks OK to me.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
> Changes since v1:
>   - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
>   - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
>  testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
>  testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
>  testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index c67db3117e29..820073709571 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
>  	SAFE_CLOSE(fd);
>  }
>  
> -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> +						      unsigned int init_flags,
> +						      unsigned int mark_flags)
>  {
>  	int fd;
>  	int rval = 0;
>  
> -	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +	fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
>  
> -	if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> +	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
>  		if (errno == EINVAL) {
>  			rval = -1;
>  		} else {
> @@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>  				    fanotify_mark_supported_by_kernel(mark_type)); \
>  } while (0)
>  
> +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> +	if (mark_type)							\
> +		REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);	\
> +	if (init_flags)							\
> +		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> +	fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> +		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 26d17e64d1f5..2081f0bd1b57 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -323,8 +323,8 @@ static void setup(void)
>  	require_fanotify_access_permissions_supported_by_kernel();
>  
>  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> -	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> -
> +	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> +								      FAN_CLASS_CONTENT, 0);
>  	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
>  
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 92e4d3ff3054..0fa9d1f4f7e4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -509,7 +509,8 @@ cleanup:
>  
>  static void setup(void)
>  {
> -	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +								      FAN_CLASS_CONTENT, 0);

I'm wondering whether this is the best combination of mask and
init_flags to use in this particular case? Maybe not to confuse future
readers, using FAN_CLASS_NOTIF explicitly here would be better, WDYT?
It doesn't make a difference, but it's something that caught my eye
while parsing this patch.

>  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
>  	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
>  									  MOUNT_PATH);
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
> index 76f1aca77615..c77dbfd8c23d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -222,7 +222,8 @@ cleanup:
>  
>  static void do_setup(void)
>  {
> -	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +								      FAN_CLASS_NOTIF, 0);
>  
>  	sprintf(fname, "fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
> -- 
> 2.33.0

/M
