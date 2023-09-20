Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9B7A71FD
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 07:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjITFZ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjITFZL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 01:25:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFECE45
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 22:23:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-578a91ac815so1555907a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 22:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695187398; x=1695792198; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VHrio7RVATAeKHB1oAtWGyonHc6+8/RsLCW99Pnpoi0=;
        b=KEw0rQyIDjq2Sc2ND9SgTp3y4yF2T830uEsUs8Ce2Ydn1rkF7bOcHBG4Br3Wf4xQ4x
         AlOnR5MxONkwIUBIZQWxWrPKvhlPnVUixKHGs+lyXt2OmUm86MhDVLFfkuTbTyu3dgRj
         bg3OgvaWHCDLEATG91zm5PKmJ62KWxDPzn2Vy+msMF1LNreIn1IPpaJQB060PtyfDyga
         Fzoy8FcSp26oWPN0FHz7g+XJTqgGT3tf5SaLQNOi2mvMN2xYIBAc86hqo8kXfFhJrsYp
         GwSVSP/INTIzXNgGJ1Z25lT+U1v3sBGLKErVEpNdM2WVvqroZzahm8vW/B4HGopahHqO
         +J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695187398; x=1695792198;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHrio7RVATAeKHB1oAtWGyonHc6+8/RsLCW99Pnpoi0=;
        b=BXTGMXSz4gVWaSgBR+FJ2SOMBrUVlyThQI6+CxsMzzsEOLcJUZX3NdxSAZsxvs9vUh
         GVEPAo4YfNJrf63KxusRU6IY6S1GM/DSv31Eo2gdl6RKOGd7x3QjG8k8B7F07GfmYVpC
         g4usi491UXP28snR2DDHL0h6i6SfHeZ9Zq29amq30w9DTf5+iYcwaOB3gQN1htG+S3Us
         +NFMMNVAiOtygJ1dnOLUgNpgvlTTSaZNckt/1zGO3sUDpzjh/sX5JmJOVdFgVTza7d5j
         h4cRcYFP7p8REbKUbzGVwISK9Dkf8bX1IjvzTvXvJOqRKBMED32/QeBsDPJiygSIoR3D
         Ft/g==
X-Gm-Message-State: AOJu0Yz3hejmhvcgGGVAuP0rmrnynBEmEPXYI+FF4gkQC9vhk9GouaEp
        YzWbBAGqKB+LAAtVcMVZMJ4Zdw64PKI=
X-Google-Smtp-Source: AGHT+IHpui3hgsS9NAjuiAFWw8vAdHIMUQhO/3YeHLD2x6UJrockEZMpjaIjZiRXJwLxAjTnNufxZw==
X-Received: by 2002:a05:6a20:4293:b0:138:2fb8:6c48 with SMTP id o19-20020a056a20429300b001382fb86c48mr1774872pzj.8.1695187397894;
        Tue, 19 Sep 2023 22:23:17 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ea8c00b001c59f23a3fesm2030126plb.251.2023.09.19.22.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:23:17 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:53:14 +0530
Message-Id: <877col770d.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>, Bobi Jam <bobijam@hotmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
In-Reply-To: <9470959E-7683-4834-A4F5-34093A600F37@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> writes:

> On Sep 12, 2023, at 12:59 AM, Bobi Jam <bobijam@hotmail.com> wrote:
>> 
>> With LVM it is possible to create an LV with SSD storage at the
>> beginning of the LV and HDD storage at the end of the LV, and use that
>> to separate ext4 metadata allocations (that need small random IOs)
>> from data allocations (that are better suited for large sequential
>> IOs) depending on the type of underlying storage.  Between 0.5-1.0% of
>> the filesystem capacity would need to be high-IOPS storage in order to
>> hold all of the internal metadata.
>> 
>> This would improve performance for inode and other metadata access,
>> such as ls, find, e2fsck, and in general improve file access latency,
>> modification, truncate, unlink, transaction commit, etc.
>> 
>> This patch split largest free order group lists and average fragment
>> size lists into other two lists for IOPS/fast storage groups, and
>> cr 0 / cr 1 group scanning for metadata block allocation in following
>> order:
>> 
>> if (allocate metadata blocks)
>>      if (cr == 0)
>>              try to find group in largest free order IOPS group list
>>      if (cr == 1)
>>              try to find group in fragment size IOPS group list
>>      if (above two find failed)
>>              fall through normal group lists as before
>> if (allocate data blocks)
>>      try to find group in normal group lists as before
>>      if (failed to find group in normal group && mb_enable_iops_data)
>>              try to find group in IOPS groups
>> 
>> Non-metadata block allocation does not allocate from the IOPS groups
>> if non-IOPS groups are not used up.
>
> Hi Ritesh,
> I believe this updated version of the patch addresses your original
> request that it is possible to allocate blocks from the IOPS block
> groups if the non-IOPS groups are full.  This is currently disabled
> by default, because in cases where the IOPS groups make up only a
> small fraction of the space (e.g. < 1% of total capacity) having data
> blocks allocated from this space would not make a big improvement
> to the end-user usage of the filesystem, but would semi-permanently
> hurt the ability to allocate metadata into the IOPS groups.
>
> We discussed on the ext4 concall various options to make this more
> useful (e.g. allowing the root user to allocate from the IOPS groups
> if the filesystem is out of space, having a heuristic to balance IOPS
> vs. non-IOPS allocations for small files, having a BPF rule that can
> specify which UID/GID/procname/filename/etc. can access this space,
> but everyone was reluctant to put any complex policy into the kernel
> to make any decision, since this eventually is wrong for some usage.
>
> For now, there is just a simple on/off switch, and if this is enabled
> the IOPS groups are only used when all of the non-IOPS groups are full.
> Any more complex policy can be deferred to a separate patch, I think.

I think having a on/off switch for any user to enable/disable allocation
of data from iops groups is good enough for now. Atleast users with
larger iops disk space won't run out of ENOSPC if they enable with this feature.

So, thanks for addressing it. I am going through the series. I will provide
my review comments shortly. 

Meanwhile, here is my understanding of your usecase. Can you please
correct add your inputs to this - 

1. You would like to create a FS with a combination of high iops storage
disk and non-high iops disk. With high iops disk space to be around 1 %
of the total disk capacity. (well this is obvious as it is stated in the
patch description itself)

2. Since ofcourse ext4 currently does not support multi-drive, so we
will use it using LVM and place high iops disk in front. 

3. Then at the creation of the FS we will use a cmd like this
   mkfs.ext4 -O sparse_super2 -E packed_meta_blocks,iops=0-1024G /path/to/lvm

Is this understanding right? 

I have few followup queries as well - 

1. What about Thin Provisioned LVM? IIUC, the space in that is
pre-allocated, but allocation happens at the time of write and it might
so happen that both data/metadata allocations will start to sit in
iops/non-iops group randomly?

2. Even in case of taditional LVM, the mapping of the physical blocks
can be changed during an overwrite or discard sort of usecase right? So
do we have a gurantee of the metadata always sitting on high iops groups
after filesystem ages?

3. With this options of mkfs to utilize this feature, we do loose the
ability to resize right? I am guessing resize will be disabled with
sparse_super2 and/or packed_meta_blocks itself?


Thanks!
-ritesh
