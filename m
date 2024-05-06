Return-Path: <linux-ext4+bounces-2306-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47B8BCBF8
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140D8B22AE6
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B9142914;
	Mon,  6 May 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OtHetVEM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADA14265C
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991114; cv=none; b=jNXOBFgI6D3mFA1adm+qaLnRrjn7H6xdlrc5vQes+Ct7li3mwx/43dFtf3zY9codD1vDnbbx0uvk+QvQKpaiBa8dSt+vKS2vID90QCfV7bs7bjSQkp7HMydnthKxc7N5INZJcZc/9Wq9mpcVHXCerRUaP9Dv2RboUrujAkAQVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991114; c=relaxed/simple;
	bh=fa2E9xf9TdvWxXSD9EMPxw6rHPjDRbcIYbzw/pzKCxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlZISIXcVI5R1UVic5KTQBvfYJvvWrgZ6Jd20LyenwEzaZA16iFjlo4MvByQlmccj3U50L2mX0kNxLlOrgXPlEJflChX0j1hINpB3TNjlXT7eObm7J5hNBOOwTs9ywORQZH9pic33H8Ucv8RFanF3nGWwulQkQy6mny2t0+OvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OtHetVEM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db17e8767cso21975121fa.3
        for <linux-ext4@vger.kernel.org>; Mon, 06 May 2024 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714991110; x=1715595910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L+P4X0/p+OGhNYzlWmLfj9ikL6C70fNhH7PqcSloxRI=;
        b=OtHetVEM6J+joFayvdNRHjr2Mwg/A1VYMRR+0TgP+WSmd/dHSdq99RAxuycIKob7tG
         LEjIKfVssmbnccUm/8Yj3jwGEj2+WaEDIaXfq2UJ0jc3hb7e51ufb1EZ2zB3HpKYpcCa
         zJmTDkS8C24sM0Z8TDcE72bd/VrTE8FgkpDIMxwrKDfbxXUFDS6ZWzsAJ4kg1D2PXL45
         YVEwRFgI3hIH/YjMWQY3TI8Q1Try5NkHXs7P8F9GVyccTFRoTZnPZXo26FE77uPLOOPI
         C95nEO4Hf2XCUplMQ84bJS/+xxAQEd0MEP3r74wp6/S1EEsqyTIgNfifMFfhKuYSrU8F
         LCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714991110; x=1715595910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+P4X0/p+OGhNYzlWmLfj9ikL6C70fNhH7PqcSloxRI=;
        b=PM6nB9vyhKZ0UMvI29gmpPALp/nS1+VDEFVdNxyOt/Powx1giA7wBbxjdBWZXhbrwY
         aiCKK5BYubld5snhpZvcKeX88GG1L1HgCtTZKnRpeF7cuattRRHBDYom3PZZTzjSvLpY
         TvbJKKXl9CemQF48xXuVXTOHQp3ygMWk1NCjSYiRo9uS/eZveSq6WtmSX6UnsinjOlK9
         ju21JCxqjpcYjEFsWQJ98GBnrNzL6q8c5GxTqsn/iANXPG+Wda/g/cV5GAxJwnrrkl/L
         JugEeJhxJfV0hpDuf9XxpFZz+CWaW5lfv0aGUO1PsVY6qp1YfPqxKowviPTinyXRb5IT
         UNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeqm0iweBU+p3muSrIrkfY5brkSNmqW1m+/FsI7f5gphiuQ7DGMVENLK/dNYhq8mCly5eLOKy97JQXyLbZ9SW/JLELaVo4sB/75Q==
X-Gm-Message-State: AOJu0YxqoljyMqiCpmmVTxIA7CPy422+8hlePZysLHibMtyyqrbg6SwC
	wIGwgs0CjZlN4T1aVOwNhyCjyNVcbLvQcMRSMCJ7gEUyDIwkhmH5GF8nmENCwRc=
X-Google-Smtp-Source: AGHT+IGOVolALyDymCWVWuMd8KtrXd0FuuGu5t8cZ3OCpxh9hHaApFb9kWNUxQx4dmu7an/cRT/cZw==
X-Received: by 2002:a2e:9ad7:0:b0:2da:ea02:3655 with SMTP id p23-20020a2e9ad7000000b002daea023655mr6743092ljj.4.1714991110143;
        Mon, 06 May 2024 03:25:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id u40-20020a056a0009a800b006ed98adec98sm7401985pfg.76.2024.05.06.03.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 03:25:09 -0700 (PDT)
Message-ID: <d8eaab72-d917-4dab-aa3a-a3946450a5e4@suse.com>
Date: Mon, 6 May 2024 19:55:03 +0930
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, y16267966@gmail.com, linux-ext4@vger.kernel.org
References: <cover.1714963428.git.anand.jain@oracle.com>
 <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
 <4c6ce351-e1fe-483a-8a9b-a1abb2324ea1@gmx.com>
 <fa9aa138-476d-413f-ac02-35156baacd66@suse.com>
 <a3bd9271-c010-4eb5-8814-0f9247ff4117@oracle.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <a3bd9271-c010-4eb5-8814-0f9247ff4117@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/6 19:26, Anand Jain 写道:
> 
>>>> . Remove RFC
>>>> . Identify the block with a merged preallocated extent and call 
>>>> fail-safe
>>>> . Qu has an idea that it could be marked as a hole, which may be 
>>>> based on
>>>>    top of this patch.
>>>
>>> Well, my idea of going holes other than preallocated extents is mostly
>>> to avoid the extra @prealloc flag parameter.
>>>
>>> But that's not a big deal for now, as I found the following way to
>>> easily crack your v2 patchset:
> 
> 
> This patch and the below test case are working as designed it is not
> a bug/crack, with the current limitation that it should fail (safer
> than silent corruption) (as shown below) when there is a merged 
> unwritten data extent.
> 
> 
>    ERROR: inode 13 index 0: identified unsupported merged block length 1 
> wanted 4
> 
> 
> This is an intermediary stage while the full support is being added.
> 
> 
> Given this option, the user will have a choice to work on the identified
> inode and make it a non-unwritten extent so that btrfs-convert shall be
> successful.

Nope, this is not acceptable.

If a completely valid ext4 (with enough space) can not be converted to 
btrfs, it's a bug in btrfs-convert and that's why we're here fixing the bug.

Requiring interruption from end user is NOT a solution.

Please update the patchset to handle such case, especially this is not 
impossible to solve.

Just mark the written part as regular data file extents, and mark the 
really unwritten one as preallocated.

If you really find it too hard to do, just let me take over.

Thanks,
Qu

> 
> 
>>>
>>>   # fallocate -l 1G test.img
>>>   # mkfs.ext4 -F test.img
>>>   # mount test.img $mnt
>>>   # xfs_io -f -c "falloc 0 16K" $mnt/file
>>>   # sync
>>>   # xfs_io -f -c "pwrite 0 4k" -c "pwrite 12k 4k" $mnt/file
>>>   # umount $mnt
>>>   # ./btrfs-convert test.img
>>> btrfs-convert from btrfs-progs v6.8
>>>
>>> Source filesystem:
>>>    Type:           ext2
>>>    Label:
>>>    Blocksize:      4096
>>>    UUID:           0f98aa2a-b1ee-4e91-8815-9b9a7b4af00a
>>> Target filesystem:
>>>    Label:
>>>    Blocksize:      4096
>>>    Nodesize:       16384
>>>    UUID:           3b8db399-8e25-495b-a41c-47afcb672020
>>>    Checksum:       crc32c
>>>    Features:       extref, skinny-metadata, no-holes, free-space-tree
>>> (default)
>>>      Data csum:    yes
>>>      Inline data:  yes
>>>      Copy xattr:   yes
>>> Reported stats:
>>>    Total space:      1073741824
>>>    Free space:        872349696 (81.24%)
>>>    Inode count:           65536
>>>    Free inodes:           65523
>>>    Block count:          262144
>>> Create initial btrfs filesystem
>>> Create ext2 image file
>>> Create btrfs metadata
>>> ERROR: inode 13 index 0: identified unsupported merged block length 1
>>> wanted 4
>>> ERROR: failed to copy ext2 inode 13: -22
>>> ERROR: error during copy_inodes -22
>>> WARNING: error during conversion, the original filesystem is not 
>>> modified
>>>
> 
> 
> 
>>> [...]
>>>> +
>>>> +    memset(&extent, 0, sizeof(struct ext2fs_extent));
>>>> +    if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
>>>> +        error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
>>>> +               src->ext2_ino);
>>>> +        ext2fs_extent_free(handle);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (extent.e_pblk != data->disk_block) {
>>>> +    error("inode %d index %d found wrong extent e_pblk %llu wanted 
>>>> disk_block %llu",
>>>> +               src->ext2_ino, index, extent.e_pblk, data->disk_block);
>>>> +        ext2fs_extent_free(handle);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (extent.e_len != data->num_blocks) {
>>>> +    error("inode %d index %d: identified unsupported merged block 
>>>> length %u wanted %llu",
>>>> +            src->ext2_ino, index, extent.e_len, data->num_blocks);
>>>> +        ext2fs_extent_free(handle);
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>> You have to split the extent in this case. As the example I gave, part
>>> of the extent can have been written.
>>> (And I'm not sure if the e_pblk check is also correct)
>>>
>>> I believe the example I gave could be a pretty good test case.
>>> (Or you can go one step further to interleave every 4K)
>>
>> Furthermore, I have to consider what is the best way to iterate all 
>> data extents of an ext2 inode.
>>
>> Instead of ext2fs_block_iterate2(), I'm wondering if 
>> ext2fs_extent_goto() would be a better solution. (As long as if it can 
>> handle holes).
>>
>> Another thing is, please Cc this series to ext4 mailing list if possible.
>> I hope to get some feedback from the ext4 exports as they may have a 
>> much better idea than us.
>>
> 
> I've tried fixes without success. Empirically, I found
> that the main issue is extent optimization and merging,
> which ignores the unwritten flag, idk where is this
> happening. I think it is during writing the ext4 image
> at the inode BTRFS_FIRST_FREE_OBJECTID + 1.
> 
> If avoiding this optimization possible, the extent boundary
> will align with ext4 and thus its flags.
> 
> Thanks, Anand
> 
> 

