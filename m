Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75DD6E2CA7
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Apr 2023 01:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDNXBz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Apr 2023 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNXBy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Apr 2023 19:01:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D86EBB
        for <linux-ext4@vger.kernel.org>; Fri, 14 Apr 2023 16:01:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a273b3b466so340095ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 14 Apr 2023 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681513312; x=1684105312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp1a1kjluZNVhpPZDVJ9ePT3GsmbnzfwOL9U8ib3LlQ=;
        b=Yx84wb7gBfazk3jnW0Ue8grsPP6hVzvp4fJspHF32wEjsRKZTcNxhQPZZOhWn6cW5E
         DNLircvthdGx8c1ESx8qhRWi8FDstC0PEM+hN6kxwSN6pD1xaSNsnYd5EeahYGeJ6xmt
         S52WbCianvDa9hulrUwSLiHAIeOjbO9/p6/dXCJDtjea920hs4u1/jsf4G7x+refmeN8
         //olkAWaZUMUkC3En0dbLIo2D+pabl64ppm131YTaGYjUZa35Vnu2vujO0HjHJJeLxe3
         LPC0pxpz2DgDwLhoI+XDwLKScUhmtbgVDqRBiGcX6sOvwhNsmTEoKJX9z1IfGOwawzpO
         wvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681513312; x=1684105312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp1a1kjluZNVhpPZDVJ9ePT3GsmbnzfwOL9U8ib3LlQ=;
        b=OtsgS6RElH/MqiZtKrGmQcm5Z1b9bbUH6Dh04W4zAvFS8NsZcjF5xzTkJGAFe4PNC1
         cvD42SsgWHq6EbGRqlZhmZWo4vQy7J186KdHiEfk7qArnUM7k+4zNv2ZmEOvUng7yOwa
         vIKo7AaX/JA0OHe7pmYtjGz69NJ2P2CUvtxR68aREqiuYUxuwY9igcxIbEqQ5Jg/rr1/
         EICw9k6phCl7ISIehJYb92Eqtmolo63hzUew2yVAuJ4yX5galw4XX7MSZgx3suyzA15T
         25RfYw15BYTdfc0N68rsQ+PFjKONr7dodgeRcmqsddMQpR1eMZPwhIM94aeDgFA1hH9s
         Buyw==
X-Gm-Message-State: AAQBX9fDsKaKUqUacUcPiEZ3djnyitCIwigtJwWRkeuAVyHepOUM4HL7
        N0TVacVSq4jckCvBZ1vR3nTdfjlq0Wbjk6gDkTETtA==
X-Google-Smtp-Source: AKy350ZQN7Bk/eUpR6DwaN3QjGGeUAsW/5vFW/d43Dh0Rhn5suxHiXX2LQwln0LbF4Cg3ozVJiWmPQ==
X-Received: by 2002:a17:903:2112:b0:19e:6b08:578c with SMTP id o18-20020a170903211200b0019e6b08578cmr55014ple.1.1681513311488;
        Fri, 14 Apr 2023 16:01:51 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709029a4c00b001a52ee4c4a5sm3508265plv.60.2023.04.14.16.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 16:01:50 -0700 (PDT)
Date:   Fri, 14 Apr 2023 16:01:47 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        linux-ext4@vger.kernel.org
Cc:     "Stephen E. Baker" <baker.stephen.e@gmail.com>,
        adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <ZDnbW1qYmBLycefL@google.com>
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu>
 <YpNk4bQlRKmgDw8E@mit.edu>
 <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu>
 <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
 <YpVeeKRH1bycP7P1@mit.edu>
 <YpVxYchs1wScNRDw@mit.edu>
 <CAFDdnB1KJVSXXzXKOc+T+g1Qewr11AS4f9tFJqSMLvfpiX-5Lg@mail.gmail.com>
 <YpjNf8WGfYh31F+2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpjNf8WGfYh31F+2@mit.edu>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 06/02/2022, Theodore Ts'o wrote:
> On Wed, Jun 01, 2022 at 10:06:04PM -0400, Stephen E. Baker wrote:
> > On Mon, May 30, 2022 at 9:37 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > > > I don't know what to tell you.  I took your config, stripped out all
> > > > of the modules, and enabled CONFIG_HYPERVISOR_GUEST,
> > > > CONFIG_VIRTIO_MENU, and CONFIG_VIRTIO_BLK, and build a 5.16 kernel.
> > >
> > Maybe a silly question, but how do I enable CONFIG_HYPERVISOR_GUEST with
> > this config.
> 
> So let's make things easy.  Attached please find my minimal config.
> This is what I use when I normally build a test kernels, and I get it
> by running "kvm-xfstests install-kconfig".  I use it because it's fast
> to build, since it doesn't build extraneous stuff.  I've also attached
> the "seb-config", which is your configuration with the minimal changes
> needed so it can run under qemu.  The compressed size is twice as big,
> and it takes 2-3 times longer to build.
> 
> I can't reproduce the problem you are seeing using kvm-xfstests using
> either kernel config building on 5.17.
> 
> 					- Ted


Hi,

I believe I figured out what is going on here since I am hitting a similar
issue with CONFIG_UNICODE. If you take a look at the .config from Stephen's
message, you'll see that he sets:

  CONFIG_TRIM_UNUSED_KSYMS=y
  CONFIG_UNUSED_KSYMS_WHITELIST=""

When trimming is enabled, kbuild will strip all exported symbols that are not
listed in the whitelist. As a result, when utf8-core.c calls:

  um->tables = symbol_request(utf8_data_table);

it will fail since `utf8_data_table` doesn't exist in the exported section of
the kernel symbol table. For me on Android, this leads to the userdata
partition failing to mount. To be clear, this happens when CONFIG_UNICODE=y.

One question I have is -- Why are we using symbol_request()/symbol_put() when
`utf8_data_table` is exported? Why can't we directly reference the
`utf8_data_table` symbol?

If we need to use symbol_request() when CONFIG_UNICODE=m, then can we apply the
below patch to fix this when CONFIG_UNICODE=y? I have verified this works for
me with CONFIG_UNICODE=y and CONFIG_TRIM_UNUSED_KSYMS=y.

Thanks,
Will


diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 67aaadc3ab072..1631bffa51b2f 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -181,9 +181,15 @@ struct unicode_map *utf8_load(unsigned int version)
                return ERR_PTR(-ENOMEM);
        um->version = version;
 
+#if defined(CONFIG_UNICODE_MODULE)
        um->tables = symbol_request(utf8_data_table);
-       if (!um->tables)
+#else
+       um->tables = &utf8_data_table;
+#endif
+       if (!um->tables) {
+               pr_err("%s: WILL: Failed to find utf8_data_table symbol!\n", __func__);
                goto out_free_um;
+       }
 
        if (!utf8version_is_supported(um, version))
                goto out_symbol_put;
@@ -198,7 +204,9 @@ struct unicode_map *utf8_load(unsigned int version)
        return um;
 
 out_symbol_put:
+#if defined(CONFIG_UNICODE_MODULE)
        symbol_put(um->tables);
+#endif
 out_free_um:
        kfree(um);
        return ERR_PTR(-EINVAL);
@@ -208,7 +216,9 @@ EXPORT_SYMBOL(utf8_load);
 void utf8_unload(struct unicode_map *um)
 {
        if (um) {
+#if defined(CONFIG_UNICODE_MODULE)
                symbol_put(utf8_data_table);
+#endif
                kfree(um);
        }
 }

