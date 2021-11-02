Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0C442C84
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 12:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhKBLaW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhKBLaV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 07:30:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F3EC061714
        for <linux-ext4@vger.kernel.org>; Tue,  2 Nov 2021 04:27:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h74so5256321pfe.0
        for <linux-ext4@vger.kernel.org>; Tue, 02 Nov 2021 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poO7iQ5eLKf23Vik4rTBqi9mweJB4HMVhR7eOi0UAbo=;
        b=LTaCvNxR0cU5QQZ/mGtUD1AgqG97RDQhxXF0Gegn7YTWQCHB23dO5jkzpBqUpnUqs4
         XF9rdFlDf6WZbe6jfqR3Xv2VYtUpQ72TNmmUVfADhgVPMijGiWYY+bgJR6eUmllEA/JA
         kUaqp1A2Bx4hEjCk5acipKIDDOszsTCeUWoj81Hv4Pfd5M5YF4MZDVPktOcHTYZ1hWNC
         ElRVxcNN96vRxWA6cECPf982llkgbJvI3CtnMqppLEk5fxtrvQS1RBEbZRqzuVdzMeuD
         h0t8qSzHC2zJQhc7D+8k+OEuDAEeSp85fO6+kcxPVOsfRmADpSM/jEUr1lMQmxy7WABf
         XNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poO7iQ5eLKf23Vik4rTBqi9mweJB4HMVhR7eOi0UAbo=;
        b=353g32oud7dyXm11qA2GKEEVGXQX6C7e9HkcFcOjupgOJUpKIemSp3dsr+M38VBZaF
         4ftFjotVQuj2daiM1NZoZ0gBUc2VRAGxHI7aWLa0rTAJ7Lv3LPcchWtbRJZ6XeeoD1nL
         0jyrJ1tldWHt2w5xG6bU8KZkRnKMeqP5k+2pyVFXGvzyMgEcQOUIftQsaRvw4UvqVMaT
         nw1KtFB9iJIqZ4YyADmcKC/+/rC1Pw1j1G9kiXeT7tl3uQnbU7sS+WP69yjyCHBQ2AXX
         VmdIOJwFAo2oEfdd8lg0R7zQ/m5FaJsOCrJubq6zSvrdYd9l0b2dvlYlgSCi8inK/F8g
         LFyQ==
X-Gm-Message-State: AOAM5302AsvzW+158uZXSR76L5QF5NSvhWiR0jkd/ds5rcFO4SMOyTVD
        0E/KXmdgKp7J2DVaKyRqoawc6Q==
X-Google-Smtp-Source: ABdhPJz0YyQNDNK0wS8N3wDrahP4zj5OidmDpiM08/I4V0oQSsPqOHyi94pj+2mkbJnn40ILj+Ek/w==
X-Received: by 2002:a05:6a00:1348:b0:481:179c:ce9b with SMTP id k8-20020a056a00134800b00481179cce9bmr9552491pfu.27.1635852466038;
        Tue, 02 Nov 2021 04:27:46 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com. [35.240.157.64])
        by smtp.gmail.com with ESMTPSA id 13sm2267614pjb.37.2021.11.02.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:27:45 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:27:38 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, ltp@lists.linux.it,
        khazhy@google.com, kernel@collabora.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/9] syscalls: fanotify: Add macro to require specific
 mark types
Message-ID: <YYEgqgFoo7oJheFr@google.com>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-2-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 29, 2021 at 06:17:24PM -0300, Gabriel Krisman Bertazi wrote:
> Like done for init flags and event types, and a macro to require a
> specific mark type.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index a2be183385e4..c67db3117e29 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>  	return rval;
>  }
>  
> +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> +	fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> +				    fanotify_mark_supported_by_kernel(mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */

A nit, but I'm of the opinion that s/_ON_/_BY_ within the macro name. Otherwise,
this looks OK to me.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

/M
