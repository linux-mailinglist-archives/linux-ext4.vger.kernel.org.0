Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649BC300A33
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbhAVRm2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 12:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbhAVRjc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 12:39:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE80C06174A;
        Fri, 22 Jan 2021 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=e6mnCZ8S34Xw26LlnLS1BlNlEKWJY2UzUNaOGO9gO6U=; b=vzgIf0OrwBiUZzWv7D3DvCqt7G
        d1mOWTwsh87xMYJO7ep6TGSMKsA7w0CEYl4vQdiQaav1ipAX0ruu7wT7rQbcs3BosaGuCurDn2wYS
        8x3nDrFVM3oGbX9uRDjGazPAVjv53mcfGBihvbwiHs6uH1FlJ67WmaSktb1clMcJ+8W5htN7jQoxF
        ngyrY+DxvHeKeTPEbdD2yph5wpmKzmGpnTPbWh/HUIGMtGV6wUtO1jB2VS6jUlIEwg/+h99y9vBH0
        kM/U0UQlIO4Q8C8YWsARhJMw2kQXwLAt4dcyzWvQ62vfAO69sDI1mNr6dvLgykp6wzJ59nNIF21qe
        XEo+Visg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l30OW-0004wg-88; Fri, 22 Jan 2021 17:38:48 +0000
Subject: Re: [PATCH resend] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS
 instead of selecting it
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210122110234.2825685-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e9dbb21-bcf5-4a9e-3729-405813ecabd3@infradead.org>
Date:   Fri, 22 Jan 2021 09:38:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210122110234.2825685-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 1/22/21 3:02 AM, Geert Uytterhoeven wrote:
> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> user may not want to enable.  Fix this by making the test depend on
> EXT4_FS instead.
> 
> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Discussion after previous submission at
> https://lore.kernel.org/linux-ext4/20201020073740.29081-1-geert@linux-m68k.org/
> ---
>  fs/ext4/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index 619dd35ddd48a973..86699c8cab281cbc 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -103,8 +103,7 @@ config EXT4_DEBUG
>  
>  config EXT4_KUNIT_TESTS
>  	tristate "KUnit tests for ext4" if !KUNIT_ALL_TESTS
> -	select EXT4_FS
> -	depends on KUNIT
> +	depends on EXT4_FS && KUNIT
>  	default KUNIT_ALL_TESTS
>  	help
>  	  This builds the ext4 KUnit tests.
> 


-- 
~Randy
