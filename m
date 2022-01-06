Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99D3485ED6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 03:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbiAFCfP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 21:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344796AbiAFCfN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 21:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641436512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Y6ec7tc6YZuXAfW6QQgoyFOZoDzPiYpbd5lseRhA/0=;
        b=RZGODGHxMqYgtJCkyRoUnvYkwVhdIpGwXMaOLjIgoyTi2m+UBmTWw2xSISwPASWkTT7Hs2
        /tGrvlp854U0O/M2fwPZIK4gj68zNK5shKr6zUQXIxyfiAVA9zuK8bGMQJlSENjI1gHVpM
        MxTD0yN53H2zrMxHVwjBrSmy99i+WyI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-u2k7TxNnN8KU6sYvi6dyaw-1; Wed, 05 Jan 2022 21:35:11 -0500
X-MC-Unique: u2k7TxNnN8KU6sYvi6dyaw-1
Received: by mail-pf1-f198.google.com with SMTP id j69-20020a628048000000b004bc8aaa6f1aso772325pfd.12
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jan 2022 18:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9Y6ec7tc6YZuXAfW6QQgoyFOZoDzPiYpbd5lseRhA/0=;
        b=BTUBLSpOKG6GJncp/OlTFxw254qoBqsupI7EhaiCSBySuOxPH5icmG4FFCQmQ6qrp5
         e4Fm4znS1JrFtnSNE1tCKjHaDkfBo/PviJsD5qyuoEX78IqGbl7C4gS6ssM36zZi2nWC
         uzsTkeQtS/GzIVN/56vJJF1uRKzMxD62B3dcNmNArqC3NqOk8oACZbaXa1pP4U8B2h3s
         wPDE7ack5HY0Wq9UfuX2+nWn0s8WvpjPe5Yi3ihuy29M/9YDwHgeR+bI4UlEC/jctzeS
         IunB6D3071eNFxfllg0In0X4MGsdPamrPj3kJ+ZTxtV0N+ETikvOUy8iQbaZ7ae/k5LI
         1+Bw==
X-Gm-Message-State: AOAM531/iXVNLL9vZgaRBaOR5/WXulvEGLtmmMSGjqTiZLPi3hF+QUip
        pTSqyfNgzd+Xi2nB5Rwmmvc5SjDa4XnQxDaoblI1tpeMl46H8lqqfgyX7M2LdRXIZ7h92vXwGtg
        XhWukBDdfyewEvPPJU/M6nQ==
X-Received: by 2002:a17:902:bc4c:b0:149:ed05:3027 with SMTP id t12-20020a170902bc4c00b00149ed053027mr1574783plz.174.1641436510655;
        Wed, 05 Jan 2022 18:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk2jZ0XLeQTU8c6nWJu02JeFt7+zVZQhYLaNw5nuVuhFEUXxNky72D+ipciYJDt9y1cHffvg==
X-Received: by 2002:a17:902:bc4c:b0:149:ed05:3027 with SMTP id t12-20020a170902bc4c00b00149ed053027mr1574760plz.174.1641436510324;
        Wed, 05 Jan 2022 18:35:10 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j17sm387009pfu.77.2022.01.05.18.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:35:10 -0800 (PST)
Date:   Thu, 6 Jan 2022 10:35:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl
 directly
Message-ID: <20220106023506.kwpzkqdpv6hozygk@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <Yb9M3aIb9cJGIJaB@desktop>
 <20211220204059.2248577-1-tytso@mit.edu>
 <20220105155743.6knpj4zsbmy62uwj@zlang-mailbox>
 <20220105160619.r66lacgq7b7ucyuk@zlang-mailbox>
 <YdX5csi2qZjS1KOt@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdX5csi2qZjS1KOt@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 05, 2022 at 03:02:58PM -0500, Theodore Ts'o wrote:
> On Thu, Jan 06, 2022 at 12:06:19AM +0800, Zorro Lang wrote:
> > > This patch looks good to me, I just want to ask if we'd better to try to include
> > > ext2fs/ext2fs.h at here? And of course, check it in configure.ac.
> > > The EXT4_IOC_RESIZE_FS looks like defined in ext2fs/ext2_fs.h which comes from
> > > e2fsprogs-devel package. I can't find this definition from kernel-hearders package.
> > > As you're the expert of this part, please correct me if it's wrong :)
> 
> We're not depending on ext2fs/ext2_fs.h and hence the e2fsprogs-devel
> (or libext2fs-dev package if you're using Debian/Ubuntu) anywhere else
> in the xfstests-dev.  It's not like the code points for
> EXT4_IOC_RESIZE_FS are going to change, so we just use constructs
> like:
> 
> #ifndef EXT4_IOC_RESIZE_FS
> #define EXT4_IOC_RESIZE_FS           _IOW('f', 16, __u64)
> #endif
> 
> in xfstests-dev/src/*.c as needed.
> 
> There's no real upside in adding a dependency which makes it harder
> for developers to compile xfstests.  (Trivia note: I created
> xfstests-bld several years ago because back then, Debian didn't
> include some of the internal header files from xfsprogs which xfstests
> needed.)

Thanks for your kindly explanation.

> 
> Cheers,
> 
> 						- Ted
> 

