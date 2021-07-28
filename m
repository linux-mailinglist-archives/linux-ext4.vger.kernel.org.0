Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE653D8AB9
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhG1Jgd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jul 2021 05:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhG1Jgd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jul 2021 05:36:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC0C061757
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jul 2021 02:36:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a7so2273151ljq.11
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jul 2021 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id
         :disposition-notification-to:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vqCntjOhCHApISDlfHYSFD/FKvR6l6WrFt2FAwG4q7w=;
        b=aJfgXHFD069iDPKn0ndvYacnyVc0WEEFF6PeNiMsoZL/89etz5w+w++MdcR6V8wT3J
         HBZHam7OcryJnlca241oFfavpodqkprCVMhjQbWmOuxIDDx0CR8W4O6jwYbqXbQTQ/kN
         GBXK236QMiO/Jk+3lDdurJPCcE2my++kHfFMqOXY7rbGdoCbiXTGR7lqLYm2QSP+L/Ch
         vsLKTFu+lSvorgxqtSoj1kQpJ4ig8IVFG0wfvpqvi5eFy1kPt+uXrZMTZJs8wo7noT8b
         KOtjYEBQYdbGCokchU4WlLF0DOjIr0Zy51i8vKSTDrsxfECdkmdDbu6ocZSnikO79DW7
         whpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id
         :disposition-notification-to:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vqCntjOhCHApISDlfHYSFD/FKvR6l6WrFt2FAwG4q7w=;
        b=GIhd7bb5vKzCgvkL+h7H1378hsg402Y8WjM4rVEWkeWnL8BIwnmyY1y2JdZljeF8fP
         gMrWLYGRgXQNmAzx80sdufitR5ApaJlSYi/4qlJ4JNj5EK6nsYKyCnHGvJ/ftJLCEO00
         0B9ye+ncUY9gvTAnqdi/OCTyUw4Vf211qHO1gvodqZalI4+sGl+v3AezPKJxl+J9vMr8
         liZ8RyVCCTEEK3TsLYWp2sU7B+ZbU0uyCnNrEqFh2q1ZbNM2GwOMIlrc+9eK+gd/DvLI
         IiUo+DCDye2dMyJ1E0VpZPSuJJDp1++K7PihUbSnLEWUEbqu1w7YMPy7rvLPpLfNAgdy
         WL5g==
X-Gm-Message-State: AOAM530IQc3nkQ+jg5KWqDSSjOmuhbL8V0JDKfJJWjntpCME/lEInlke
        w1KCgp+4/ZHzhJ2dx3W/q/V3sbl39091Fg==
X-Google-Smtp-Source: ABdhPJznxunagXzx90hSSONsx5uS7wF2m1PHplRdCKQDtd+Jh5s8p30uscYhgT+c4PXdSJKUgbUvxg==
X-Received: by 2002:a05:651c:329:: with SMTP id b9mr18461821ljp.116.1627464989026;
        Wed, 28 Jul 2021 02:36:29 -0700 (PDT)
Received: from localhost (public-gprs557148.centertel.pl. [37.225.39.157])
        by smtp.gmail.com with ESMTPSA id g36sm595874lfv.90.2021.07.28.02.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:36:28 -0700 (PDT)
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
 <YQCQODCGtJRTKwS9@mit.edu>
From:   Mikhail Morfikov <mmorfikov@gmail.com>
Subject: Re: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
Message-ID: <ba95a978-18af-794a-4c9d-a8406ade31ae@gmail.com>
Date:   Wed, 28 Jul 2021 11:36:27 +0200
MIME-Version: 1.0
In-Reply-To: <YQCQODCGtJRTKwS9@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the answer.

I have one question. Basically there's the /etc/mke2fs.conf file and 
I've created the following stanza in it:

bigdata = {
                errors = remount-ro
                features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,bigalloc,^uninit_bg,sparse_super2
                inode_size = 256
                inode_ratio = 4194304
                cluster_size = 4M
                reserved_ratio = 0
                lazy_itable_init = 0
                lazy_journal_init = 0
        }

It looks like the cluster_size parameter is ignored in such case (I've 
tried both 4M and 4194304 values), and the filesystem was created with 
64K cluster size (via mkfs -t bigdata -L bigdata /dev/sdb1 ), which is 
the default when the bigalloc feature is set. 

So it looks like the cluster_size doesn't do anything when set in 
/etc/mke2fs.conf . When I used the -C 4M flag (i.e. 
mkfs -t bigdata -L bigdata -C 4M /dev/sdb1), the cluster size was set to 
4M as it should.

Is something wrong with the cluster_size parameter set in the 
/etc/mke2fs.conf file?

----
# mkfs -V
mkfs from util-linux 2.36.1




On 28/07/2021 01.01, Theodore Ts'o wrote:
> On Fri, Jul 23, 2021 at 05:30:13PM +0200, Mikhail Morfikov wrote:
>> In the man ext4(5) we can read the following:
>>
>>     Warning: The bigalloc feature is still under development, 
>>     and may not be fully supported with your kernel or may 
>>     have various bugs. Please see the web page 
>>     http://ext4.wiki.kernel.org/index.php/Bigalloc for details. 
>>     May clash with delayed allocation (see nodelalloc mount 
>>     option).
>>
>> According to the link above, the info is dated back to 2013, 
>> which is a little bit ancient.
>>
>> What's the current status of the feature? Is it safe to use 
>> bigalloc on several TiB hard disks where only big files will be 
>> stored?
> 
> Yes; the places where bigalloc is perhaps not as well tested is
> support FALLOC_FL_COLLAPSE_RANGE, FALLOC_FL_INSERT_RANGE, and
> FALLOC_FL_PUNCH_HOLE.  Bigalloc is also not very efficient for large
> directories (where we allocate a full cluster for each directory
> block).  Older kernels did not handle ENOSPC errors when delayed
> allocation was enabled, but that has since been fixed, and bigalloc is
> passing file system regression tests, so it should safe to use as
> you've described.
> 
> Cheers,
> 
> 					- Ted
> 					
> 
