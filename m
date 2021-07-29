Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D694A3DAAEC
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jul 2021 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhG2ScK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jul 2021 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhG2ScJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jul 2021 14:32:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DAC061765
        for <linux-ext4@vger.kernel.org>; Thu, 29 Jul 2021 11:32:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l18so8086537wrv.5
        for <linux-ext4@vger.kernel.org>; Thu, 29 Jul 2021 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id
         :disposition-notification-to:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yAQ3/pmMsKqs1ajOPUeVegjM/dmndlpcKkkkmKiwl7k=;
        b=f89+OkT230fgNNasFthRvjcoS4WofO+w+uhBzLEwHLPt/HeC3BtWV7pM04hrwPLwmL
         AysNvAJYCplq0ujzlpinpBk7YyzdPUATC94RZ5VWhH3/R0JRkqaCMRRuI9TvC2ZlWvNk
         rjcHppHRNgd2lc/tOd1UUcD+KqCQbxQKRsi0nHwPxVJN+zk+CxS+gNQOj3l/Zim4/x76
         v4qzqUjPnpSFVW7xns1Vn7juULj2H88OYKIi7Yi5pANw+5N21vGt8IKNomJnRtsWH/c4
         cvbd0zBDD9RuBSRdk3u5r2IJ4QuCQZUuEOJTy406H2ggWsd24JjN0kKouC9Nc3C1aBke
         ggFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id
         :disposition-notification-to:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yAQ3/pmMsKqs1ajOPUeVegjM/dmndlpcKkkkmKiwl7k=;
        b=BTJk00veOiCzs8OC7zyzkzUQ1qvtn+C/QoAmFldJxpaqqok/XfRwolOB7VrKMY6uYM
         o8dHsykMxj2n9sC5WfIQdSbOxmuSTxPQdpT+PY0059gEd45UQcdJfhTm790VWiLxluwe
         NcL+k/1kG7azYQTnGcfN+hHEuoh/T4BbAlWKEYQbDsPyZnaF2nmchn8waFFMJHRJzGcd
         THVPIlispwaXU2PEVcU9HtjuB9V6+vGTkR7TBhyF9NHaUNxczpuVrkgsuuGJFw/haESg
         9shKw1Pm8Q3dUrEj9aYQee7p5BA19edQcKo84J1Di4jLGB5RiFoxJ3oKMRT2yY9L+aRX
         BqYg==
X-Gm-Message-State: AOAM531cY0OYppITWjRtWRFfA38/+uo8r+qba1zceCgjVpeCw150k14c
        pFkQsMLpH4JAcTjWOVi4smsr6qyyEjQ=
X-Google-Smtp-Source: ABdhPJwqZPo/lAnMZVYzBa8x06QboW0ZdkptEfqn89N5quYLJT3TqaFtQuwyXZPcCNDxRNG/VZ9qEg==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr6255432wrt.132.1627583523453;
        Thu, 29 Jul 2021 11:32:03 -0700 (PDT)
Received: from localhost (public-gprs548858.centertel.pl. [37.225.7.59])
        by smtp.gmail.com with ESMTPSA id m39sm6297268wms.28.2021.07.29.11.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 11:32:03 -0700 (PDT)
Subject: Re: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
 <YQCQODCGtJRTKwS9@mit.edu> <ba95a978-18af-794a-4c9d-a8406ade31ae@gmail.com>
 <YQLsl7s/GcgMGi47@mit.edu>
From:   Mikhail Morfikov <mmorfikov@gmail.com>
Message-ID: <ebcb2e10-2528-6c5e-cdd4-ceeaeedb0ae6@gmail.com>
Date:   Thu, 29 Jul 2021 20:32:01 +0200
MIME-Version: 1.0
In-Reply-To: <YQLsl7s/GcgMGi47@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 29/07/2021 19.59, Theodore Ts'o wrote:
> On Wed, Jul 28, 2021 at 11:36:27AM +0200, Mikhail Morfikov wrote:
>> Thanks for the answer.
>>
>> I have one question. Basically there's the /etc/mke2fs.conf file and 
>> I've created the following stanza in it:
>>
>> bigdata = {
>>                 errors = remount-ro
>>                 features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,bigalloc,^uninit_bg,sparse_super2
>>                 inode_size = 256
>>                 inode_ratio = 4194304
>>                 cluster_size = 4M
>>                 reserved_ratio = 0
>>                 lazy_itable_init = 0
>>                 lazy_journal_init = 0
>>         }
>>
>> It looks like the cluster_size parameter is ignored in such case (I've 
>> tried both 4M and 4194304 values), and the filesystem was created with 
>> 64K cluster size (via mkfs -t bigdata -L bigdata /dev/sdb1 ), which is 
>> the default when the bigalloc feature is set.
> 
> It does work, but you need to use an integer value for cluster_size,
> and it needs to be in the [fs_types[ section.  So something like what I
> have attached below.
> 
> And then try using the command "mke2fs -t ext4 -T bigdata -L bigdata
> /dev/sdb1".

Yes, this helped and the cluster size was set to 4194304 as it should.

> 
> If you see the hugefile and hugefiles stanzas below, that's an example
> of one way bigalloc has gotten a fair amount of use.  In this use case
> mke2fs has pre-allocated the huge data files guaranteeing that they
> will be 100% contiguous.  We're using a 32k cluster becuase there are
> some metadata files where better allocation efficiencies is desired.

I'll try them both and see whether I could use either one of them on 
my drive.

> 
> Cheers,
> 
> 						- Ted
> 
> [defaults]
> 	base_features = sparse_super,large_file,filetype,resize_inode,dir_index,ext_attr
> 	default_mntopts = acl,user_xattr
> 	enable_periodic_fsck = 0
> 	blocksize = 4096
> 	inode_size = 256
> 	inode_ratio = 16384
> 	undo_dir = /var/lib/e2fsprogs/undo
> 
> [fs_types]
> 	ext3 = {
> 		features = has_journal
> 	}
> 	ext4 = {
> 		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
> 		inode_size = 256
> 	}
> 	small = {
> 		blocksize = 1024
> 		inode_size = 128
> 		inode_ratio = 4096
> 	}
> 	floppy = {
> 		blocksize = 1024
> 		inode_size = 128
> 		inode_ratio = 8192
> 	}
> 	big = {
> 		inode_ratio = 32768
> 	}
> 	huge = {
> 		inode_ratio = 65536
> 	}
> 	news = {
> 		inode_ratio = 4096
> 	}
> 	largefile = {
> 		inode_ratio = 1048576
> 		blocksize = -1
> 	}
> 	largefile4 = {
> 		inode_ratio = 4194304
> 		blocksize = -1
> 	}
> 	hurd = {
> 	     blocksize = 4096
> 	     inode_size = 128
> 	}
> 	hugefiles = {
> 		features = extent,huge_file,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
> 		hash_alg = half_md4
> 		reserved_ratio = 0.0
> 		num_backup_sb = 0
> 		packed_meta_blocks = 1
> 		make_hugefiles = 1
> 		inode_ratio = 4194304
> 		hugefiles_dir = /storage
> 		hugefiles_name = chunk-
> 		hugefiles_digits = 5
> 		hugefiles_size = 4G
> 		hugefiles_align = 256M
> 		hugefiles_align_disk = true
> 		zero_hugefiles = false
> 		flex_bg_size = 262144
> 	}
> 
> 	hugefile = {
> 		features = extent,huge_file,bigalloc,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
> 		cluster_size = 32768
> 		hash_alg = half_md4
> 		reserved_ratio = 0.0
> 		num_backup_sb = 0
> 		packed_meta_blocks = 1
> 		make_hugefiles = 1
> 		inode_ratio = 4194304
> 		hugefiles_dir = /storage
> 		hugefiles_name = huge-file
> 		hugefiles_digits = 0
> 		hugefiles_size = 0
> 		hugefiles_align = 256M
> 		hugefiles_align_disk = true
> 		num_hugefiles = 1
> 		zero_hugefiles = false
> 	}
> 	bigdata = {
> 		errors = remount-ro
> 		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,bigalloc,^uninit_bg,sparse_super2
> 		inode_size = 256
> 		inode_ratio = 4194304
> 		cluster_size = 4194304
> 		reserved_ratio = 0
> 		lazy_itable_init = 0
> 		lazy_journal_init = 0
> 	}
> 
