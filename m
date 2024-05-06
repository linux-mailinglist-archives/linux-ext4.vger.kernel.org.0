Return-Path: <linux-ext4+bounces-2303-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E58BC738
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 07:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6158D1F20F02
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 05:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD106481A6;
	Mon,  6 May 2024 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KLgZe9t3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D747F4A
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975173; cv=none; b=kgTK3h41ecIeq9Td6fyQ3QkWbgd9Qw0pGCsuhFOOAUvn2+fng3DaQysfUQvmDCmKFoe/3zB4+fTsI24g7v2LZi4hvxALlkpTmAhQFLAUMarxJM9gk9S6QyvUUOJc5M2InunZgrDvn9CTTF3BHkY/lHgOHBB/N1NOHiozvCurebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975173; c=relaxed/simple;
	bh=xwlPk8NTGZCLMq3yAxdUSizxvN0TxMcy2LlvErP4tUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ud8KQ8Y/7mPmAaiEronzPjkhxqvTctp4ffTOCME520hLVwPoBIaAH9nA4pKfPIUiGfgGuQTqUjkG5tpoJ6c1pe/OGNqxZonIq8B5xWvniK5u9Cfh+i0E7UHTMIcltjRDX9kGH/yZKDuPKUfjaqVRTCWdkuG8ZrvEoLPogprOxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KLgZe9t3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so19359081fa.3
        for <linux-ext4@vger.kernel.org>; Sun, 05 May 2024 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714975168; x=1715579968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+FJiWBQkwIj0St36qVFqOXjyyr0v824XVev1VQRdQ8g=;
        b=KLgZe9t3yPQH/TjdwN4s4XWEKIyjaO1NBcvY2wFJF62wmpUSiDywWaLytvRUtBbgR5
         KNR7nQMHD1oyej+InNUBS7gcI59xnRQ8Na68GhcI66X1x2VpMVLIf3zjAsEBHSXocXSE
         noW3HXFQxFTBt2twQY9A+Me4RkTgAuYUzeSiktNthRRkdAxz/vCI25fZBm21eA+eIL3l
         iN5D/EItKlRXJ6Ho+Bn7eyyJXWpgoPvi5Wwwgg29BfJp13kjpMBKCj84SdzG4ONH11q/
         yjs/QKhaxqHuddvAXIGxQ4hdAYhvb2ycXxHoWyfyjL8m0AqrAQIaPOQ8S3d74ldMJ4+h
         N9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714975168; x=1715579968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FJiWBQkwIj0St36qVFqOXjyyr0v824XVev1VQRdQ8g=;
        b=euxavHksZNGNycxGA1JZD48pmCn9jq0ULnqkuWzJZjOs+YtT4z2R9y3S/ubYk5qHHA
         hyi2Q9U20GoXmftD3G+JqDVicCfdxct7VnT9PlrGzMtaCUkKVcQAU1lcmBsK192xqm4T
         mQDP9Jo04and5ibQX49XSUkjomOZpAh1uEJi9+s0U9754H48AUqdnfvPaISSklVaLYKF
         ouZ164MXt+usqmr+ptXQuMYG3td2xGC5Z4ovSfaiKD8BZqG6+jPaeGQlXWZ8nqoczb/R
         /07sNea2dClVmHxQOnX6mpYB+DaIn78BwbjPOxJ/oTrVZ/MR8LtlSrq28dTKjQFSJwCr
         fuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVRyvQpkaBOjo9Xg0VlbeHpVbXeaiVwfFaQjriHrj4CzrPJsUt1d4kqbwvg1CgVq6nwruU5lGSPPUq0BnDCjuy4Ul4vTUvuk7dMjg==
X-Gm-Message-State: AOJu0YyMXLOFdhz9pwrSs+LkTzf+UPZBlZMZposCvQoz9ijTer+gFLgj
	NvsSq0Ili+UH4q0y3VNvja1WULW66n4EBuMCjXPi798JY2ebnNRMB6joN9PtLf0=
X-Google-Smtp-Source: AGHT+IEFrZCBMg7W0HlisVGHwuX6bpNXjdjActUPHXHjuKiYry1yPGFLpRkDPwLYWLExwyUAIxvJpA==
X-Received: by 2002:a2e:a23a:0:b0:2e1:d34d:9b2c with SMTP id i26-20020a2ea23a000000b002e1d34d9b2cmr5246704ljm.9.1714975168478;
        Sun, 05 May 2024 22:59:28 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090a71c500b002b436698285sm5569835pjs.43.2024.05.05.22.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 22:59:27 -0700 (PDT)
Message-ID: <fa9aa138-476d-413f-ac02-35156baacd66@suse.com>
Date: Mon, 6 May 2024 15:29:22 +0930
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Anand Jain <anand.jain@oracle.com>,
 linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, y16267966@gmail.com, linux-ext4@vger.kernel.org
References: <cover.1714963428.git.anand.jain@oracle.com>
 <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
 <4c6ce351-e1fe-483a-8a9b-a1abb2324ea1@gmx.com>
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
In-Reply-To: <4c6ce351-e1fe-483a-8a9b-a1abb2324ea1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/6 15:11, Qu Wenruo 写道:
> 
> 
> 在 2024/5/6 12:34, Anand Jain 写道:
>> This patch, along with the dependent patches below, adds support for
>> ext4 unmerged  unwritten file extents as preallocated file extent in 
>> btrfs.
>>
>>   btrfs-progs: convert: refactor ext2_create_file_extents add argument 
>> ext2_inode
>>   btrfs-progs: convert: struct blk_iterate_data, add ext2-specific 
>> file inode pointers
>>   btrfs-progs: convert: refactor __btrfs_record_file_extent to add a 
>> prealloc flag
>>
>> The patch is developed with POV of portability with the current
>> e2fsprogs library.
>>
>> This patch will handle independent unwritten extents by marking them 
>> with prealloc
>> flag and will identify merged unwritten extents, triggering a fail.
>>
>> Testcase:
>>
>>       $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=1 conv=fsync 
>> status=none
>>       $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=2 conv=fsync 
>> seek=1 status=none
>>       $ xfs_io -f -c 'falloc -k 12K 12K' /mnt/test/foo
>>       $ dd if=/dev/zero of=/mnt/test/foo bs=4K count=1 conv=fsync 
>> seek=6 status=none
>>
>>       $ filefrag -v /mnt/test/foo
>>       Filesystem type is: ef53
>>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>>      ext:     logical_offset:        physical_offset: length:   
>> expected: flags:
>>        0:        0..       0:      33280..     33280:      1:
>>        1:        1..       2:      33792..     33793:      2:      33281:
>>        2:        3..       5:      33281..     33283:      3:      
>> 33794: unwritten
>>        3:        6..       6:      33794..     33794:      1:      
>> 33284: last,eof
>>
>>       $ sha256sum /mnt/test/foo
>>       
>> 18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  
>> /mnt/test/foo
>>
>>     Convert and compare the checksum
>>
>>     Before:
>>
>>       $ filefrag -v /mnt/test/foo
>>       Filesystem type is: 9123683e
>>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>>        ext:     logical_offset:        physical_offset: length:   
>> expected: flags:
>>        0:        0..       0:      33280..     33280:      
>> 1:             shared
>>        1:        1..       2:      33792..     33793:      2:      
>> 33281: shared
>>        2:        3..       6:      33281..     33284:      4:      
>> 33794: last,shared,eof
>>       /mnt/test/foo: 3 extents found
>>
>>       $ sha256sum /mnt/test/foo
>>       
>> 6874a1733e5785682210d69c07f256f684cf5433c7235ed29848b4a4d52030e0  
>> /mnt/test/foo
>>
>>     After:
>>
>>       $ filefrag -v /mnt/test/foo
>>       Filesystem type is: 9123683e
>>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>>      ext:     logical_offset:        physical_offset: length:   
>> expected: flags:
>>        0:        0..       0:      33280..     33280:      
>> 1:             shared
>>        1:        1..       2:      33792..     33793:      2:      
>> 33281: shared
>>        2:        3..       5:      33281..     33283:      3:      
>> 33794: unwritten,shared
>>        3:        6..       6:      33794..     33794:      1:      
>> 33284: last,shared,eof
>>       /mnt/test/foo: 4 extents found
>>
>>       $ sha256sum /mnt/test/foo
>>       
>> 18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  
>> /mnt/test/foo
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>
>> . Remove RFC
>> . Identify the block with a merged preallocated extent and call fail-safe
>> . Qu has an idea that it could be marked as a hole, which may be based on
>>    top of this patch.
> 
> Well, my idea of going holes other than preallocated extents is mostly
> to avoid the extra @prealloc flag parameter.
> 
> But that's not a big deal for now, as I found the following way to
> easily crack your v2 patchset:
> 
>   # fallocate -l 1G test.img
>   # mkfs.ext4 -F test.img
>   # mount test.img $mnt
>   # xfs_io -f -c "falloc 0 16K" $mnt/file
>   # sync
>   # xfs_io -f -c "pwrite 0 4k" -c "pwrite 12k 4k" $mnt/file
>   # umount $mnt
>   # ./btrfs-convert test.img
> btrfs-convert from btrfs-progs v6.8
> 
> Source filesystem:
>    Type:           ext2
>    Label:
>    Blocksize:      4096
>    UUID:           0f98aa2a-b1ee-4e91-8815-9b9a7b4af00a
> Target filesystem:
>    Label:
>    Blocksize:      4096
>    Nodesize:       16384
>    UUID:           3b8db399-8e25-495b-a41c-47afcb672020
>    Checksum:       crc32c
>    Features:       extref, skinny-metadata, no-holes, free-space-tree
> (default)
>      Data csum:    yes
>      Inline data:  yes
>      Copy xattr:   yes
> Reported stats:
>    Total space:      1073741824
>    Free space:        872349696 (81.24%)
>    Inode count:           65536
>    Free inodes:           65523
>    Block count:          262144
> Create initial btrfs filesystem
> Create ext2 image file
> Create btrfs metadata
> ERROR: inode 13 index 0: identified unsupported merged block length 1
> wanted 4
> ERROR: failed to copy ext2 inode 13: -22
> ERROR: error during copy_inodes -22
> WARNING: error during conversion, the original filesystem is not modified
> 
> [...]
>> +
>> +    memset(&extent, 0, sizeof(struct ext2fs_extent));
>> +    if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
>> +        error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
>> +               src->ext2_ino);
>> +        ext2fs_extent_free(handle);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (extent.e_pblk != data->disk_block) {
>> +    error("inode %d index %d found wrong extent e_pblk %llu wanted 
>> disk_block %llu",
>> +               src->ext2_ino, index, extent.e_pblk, data->disk_block);
>> +        ext2fs_extent_free(handle);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (extent.e_len != data->num_blocks) {
>> +    error("inode %d index %d: identified unsupported merged block 
>> length %u wanted %llu",
>> +            src->ext2_ino, index, extent.e_len, data->num_blocks);
>> +        ext2fs_extent_free(handle);
>> +        return -EINVAL;
>> +    }
> 
> You have to split the extent in this case. As the example I gave, part
> of the extent can have been written.
> (And I'm not sure if the e_pblk check is also correct)
> 
> I believe the example I gave could be a pretty good test case.
> (Or you can go one step further to interleave every 4K)

Furthermore, I have to consider what is the best way to iterate all data 
extents of an ext2 inode.

Instead of ext2fs_block_iterate2(), I'm wondering if 
ext2fs_extent_goto() would be a better solution. (As long as if it can 
handle holes).

Another thing is, please Cc this series to ext4 mailing list if possible.
I hope to get some feedback from the ext4 exports as they may have a 
much better idea than us.

Thanks,
Qu
> 
> Thanks,
> Qu
> 
>> +
>> +    if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
>> +        *has_unwritten = true;
>> +
>> +    return 0;
>> +}
>> +
>>   static int ext2_dir_iterate_proc(ext2_ino_t dir, int entry,
>>                   struct ext2_dir_entry *dirent,
>>                   int offset, int blocksize,
>> diff --git a/convert/source-ext2.h b/convert/source-ext2.h
>> index 026a7cad8ac8..19014d3c25e6 100644
>> --- a/convert/source-ext2.h
>> +++ b/convert/source-ext2.h
>> @@ -82,6 +82,9 @@ struct ext2_source_fs {
>>       ext2_ino_t ext2_ino;
>>   };
>>
>> +int ext2_find_unwritten(struct blk_iterate_data *data, int index,
>> +            bool *has_unwritten);
>> +
>>   #define EXT2_ACL_VERSION    0x0001
>>
>>   #endif    /* BTRFSCONVERT_EXT2 */
>> diff --git a/convert/source-fs.c b/convert/source-fs.c
>> index df5ce66caf7f..88a6ceaf41f6 100644
>> --- a/convert/source-fs.c
>> +++ b/convert/source-fs.c
>> @@ -31,6 +31,7 @@
>>   #include "common/extent-tree-utils.h"
>>   #include "convert/common.h"
>>   #include "convert/source-fs.h"
>> +#include "convert/source-ext2.h"
>>
>>   const struct simple_range btrfs_reserved_ranges[3] = {
>>       { 0,                 SZ_1M },
>> @@ -239,6 +240,15 @@ fail:
>>       return ret;
>>   }
>>
>> +int find_prealloc(struct blk_iterate_data *data, int index,
>> +          bool *has_prealloc)
>> +{
>> +    if (data->source_fs)
>> +        return ext2_find_unwritten(data, index, has_prealloc);
>> +
>> +    return -EINVAL;
>> +}
>> +
>>   /*
>>    * Record a file extent in original filesystem into btrfs one.
>>    * The special point is, old disk_block can point to a reserved range.
>> @@ -257,6 +267,7 @@ int record_file_blocks(struct blk_iterate_data *data,
>>       u64 old_disk_bytenr = disk_block * sectorsize;
>>       u64 num_bytes = num_blocks * sectorsize;
>>       u64 cur_off = old_disk_bytenr;
>> +    int index = data->first_block;
>>
>>       /* Hole, pass it to record_file_extent directly */
>>       if (old_disk_bytenr == 0)
>> @@ -276,6 +287,16 @@ int record_file_blocks(struct blk_iterate_data 
>> *data,
>>           u64 extent_num_bytes;
>>           u64 real_disk_bytenr;
>>           u64 cur_len;
>> +        u64 flags = BTRFS_FILE_EXTENT_REG;
>> +        bool has_prealloc = false;
>> +
>> +        if (find_prealloc(data, index, &has_prealloc)) {
>> +            data->errcode = -1;
>> +            return -EINVAL;
>> +        }
>> +
>> +        if (has_prealloc)
>> +            flags = BTRFS_FILE_EXTENT_PREALLOC;
>>
>>           key.objectid = data->convert_ino;
>>           key.type = BTRFS_EXTENT_DATA_KEY;
>> @@ -316,12 +337,12 @@ int record_file_blocks(struct blk_iterate_data 
>> *data,
>>                     old_disk_bytenr + num_bytes) - cur_off;
>>           ret = btrfs_record_file_extent(data->trans, data->root,
>>                       data->objectid, data->inode, file_pos,
>> -                    real_disk_bytenr, cur_len,
>> -                    BTRFS_FILE_EXTENT_REG);
>> +                    real_disk_bytenr, cur_len, flags);
>>           if (ret < 0)
>>               break;
>>           cur_off += cur_len;
>>           file_pos += cur_len;
>> +        index++;
>>
>>           /*
>>            * No need to care about csum
>> diff --git a/convert/source-fs.h b/convert/source-fs.h
>> index 25916c65681b..db7ead422585 100644
>> --- a/convert/source-fs.h
>> +++ b/convert/source-fs.h
>> @@ -153,5 +153,6 @@ int read_disk_extent(struct btrfs_root *root, u64 
>> bytenr,
>>                       u32 num_bytes, char *buffer);
>>   int record_file_blocks(struct blk_iterate_data *data,
>>                     u64 file_block, u64 disk_block, u64 num_blocks);
>> +int find_prealloc(struct blk_iterate_data *data, int index, bool 
>> *has_prealloc);
>>
>>   #endif

