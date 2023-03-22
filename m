Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA26C5142
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 17:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCVQvs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCVQvk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 12:51:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CA5D751
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 09:51:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso19748798pjb.3
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679503884;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iGszKxJwvNJZCWcq3zluzfVStuWtqy44b5fzPeZaUlI=;
        b=m6zozs2W8XFTM6Kazv+Odz1XPuREB3NXgB7iOjY8e6ezqtrfQJQKUQJYPGVUPP9b9D
         2DGFBkFifhQlS/V7gTRst85J9x5wamKdVYWmMDQX0y6VgJ6yNKJ6yJPFXMyjZhYNz96y
         sPYef1g6PSEWVxz45BKK5UCxS5jz5mFcGUlMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503884;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGszKxJwvNJZCWcq3zluzfVStuWtqy44b5fzPeZaUlI=;
        b=gkJMyASZPHyw1MueelcVIH9kgeKMIwSdklkAWziZPzIm+hhMNsTNITOMgojVog62YJ
         RgMGsQg9jjM09oexRKm6OUWa6QU/Koinad8U3y/cI9/5380pqZMpvWV0r5w7qIXezTIz
         rZAol34AbDYTCUn/kUmWygiIWK4oTvts4AVp0RQP7fg6Kv5+ROBu0zpV08DMn43Uk69A
         WYYvKYGjNPJYfFDYzy597YfLvutnxA+s3rGFPM8owyVaUPPR9jPLeDmyXTZ+5QSi12oN
         DE8LfaJ41W9zPdUXBvvatiP2kxdCKfTjz6ouyw/0s+8BteNT1x1eKoyb3+7PxjnagCGx
         04hw==
X-Gm-Message-State: AO0yUKUmhvOGY/6CWtiMRJMmlYszAZ4EMMjzIo0hbcmKqS+27/l3lLNQ
        IzjK+luPAEtRJKtUrKQBrD7qhA==
X-Google-Smtp-Source: AK7set+MERdHMdbwPj0ByetHCcw8mI8yDaE0Sz8+ylswOFlKgT+bR0Nm4Pg6dFdjtQ9EEochi8+JyQ==
X-Received: by 2002:a05:6a20:b291:b0:d9:3aa9:20e3 with SMTP id ei17-20020a056a20b29100b000d93aa920e3mr396835pzb.0.1679503883834;
        Wed, 22 Mar 2023 09:51:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a3-20020aa780c3000000b00628e9871c24sm1661235pfn.183.2023.03.22.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:51:23 -0700 (PDT)
Message-ID: <641b320b.a70a0220.2bb1d.30fc@mx.google.com>
X-Google-Original-Message-ID: <202303220950.@keescook>
Date:   Wed, 22 Mar 2023 09:51:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] lib/string_helpers: Change returned value of the
 strreplace()
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
 <20230322141206.56347-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322141206.56347-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 04:12:05PM +0200, Andy Shevchenko wrote:
> It's more useful to return the original string with strreplace(),

I found the use of "original" confusing here and in the comments. This
just returns arg 1, yes? i.e. it's not the original (unreplaced) string,
but rather just the string itself.

I agree, though, that's much more useful than a pointer to the end of
the string.

-Kees

-- 
Kees Cook
