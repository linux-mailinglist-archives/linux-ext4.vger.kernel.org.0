Return-Path: <linux-ext4+bounces-2280-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CC8BA9FD
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 11:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E51C2140F
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500314F9F8;
	Fri,  3 May 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VGV/JV8H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7442078
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729065; cv=none; b=aJAarS7jq1zR1fpl0UquSa/g6VnlGvjBI3s49lnUcPxY+OmGkugQSta9XhH+4CX0jpWL5m5Qr3lxWYNXddQahQlPregryvM7vgP2KN3i8KiDN8THk8HjwfDFidgYd8YSOOIG5krh06m9sWQmRJfXuC9U2qn62Z2Z9QTmlJA+myQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729065; c=relaxed/simple;
	bh=MUDMXGhnmgCttahpDBLYCsS3yirlf+8mMqFpJSFLoaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TuAWZTXASqbuw4JlULEe7H9oxZZeLO/pVOJgVoXIpeGR3uR1mTVRf+E33SVczkSIB2ngaBFYnNnmahmIk++pCekPxkuC//ZNqj4hVWbeIZQF95PErsJUDkHZ026DEVnLYhkxy4hdg4ed4UM2ooR4gp37+TEQULotSaZTwHbkxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VGV/JV8H; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso1081936f8f.1
        for <linux-ext4@vger.kernel.org>; Fri, 03 May 2024 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714729060; x=1715333860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r3ZjahHZ6zMJICY7twkxvFwt8SZIyE9UiR0xavsVa48=;
        b=VGV/JV8Hpo+UwmfovswDZznwAgrE4RKsANboPG5zl/Tjxu2omQfzSH9oHM+Css9+VJ
         UG+w9wfRNSYah5Cj2ahTZuf4J5yt8QZeG0RO1vv1zca6RtoVZqXmPRWN2yUAQn/B6EOk
         QgCJYxehO5NLG1kOcw2lDGHAHptt+iyA0aBzy+aKy8efENFtr3jSERXJJ2uBVT3x49CM
         2xRqWtGwYKqmIubwLWD61eKyno5CYd7J2TTyLdQblcKTrDMkUlXcwtcQB95nzmauO1WW
         gmrvp5xMUaC2Hvptw+5O4w7Kow2lLHOIFFizi7USnUK64WrB5M6DIF+s9pa5KhUw5LJM
         ZVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729060; x=1715333860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3ZjahHZ6zMJICY7twkxvFwt8SZIyE9UiR0xavsVa48=;
        b=LsOjOb8hUcT4Xj0+ztoOj3KM2hI/O8Dzr0MCXDGa+AGET/LkXBaJbOICZ1meJmMloI
         cYnaDAAZZ4xGzUDt1Q3XPeIzrMXk3X3WPz2srO77uxUUw6NH8FmPGb0Lq45buXtQwu/N
         3VBVybxvRmPm2SPMJw8J3xZ36B5klS6tmK7kx4EsYzUi7vRzBFmWzf3b3InXgEgF+5Sn
         Zcd6Pwx6BvDtrYc6OYc8AJ+4bP5VNz1OBcyeui5QdabgVOo6iCZUDnPRmdgptTbbzeTa
         huYVqUaY+UBbRPUtAbveih/AlX/Z/xxzEjNpcjvTDjeqVtsZqrpmEj8S/md4hgEZ8SoO
         q9sA==
X-Forwarded-Encrypted: i=1; AJvYcCX21pKCDQLTQ53aihJ0tT594jatK8r4eWtAGdtXKwmjHoDRL8OKggqfmNfspI8uiDUX5N7HINrie6yZ65Ond3kHlM13Gyebmitihg==
X-Gm-Message-State: AOJu0Yxw0g4wHHKY03PYKdk1OZj/rjmVTqMv85uMjmlLIJNHKm9tDDHu
	1ndSgmosdcQMr+upcdJMtCsCsizVMlbvw1xGZvsO61jNWJRg30q1ixyPdB10ly4=
X-Google-Smtp-Source: AGHT+IEolOZ48yES3mwawHw4rWIYuPyIg7EEZMVVZ7HgzZxXkAEJJMPQ5xDio/1GS/tB1XIbe2i7Xg==
X-Received: by 2002:a05:6000:188:b0:34d:c4c7:7ca with SMTP id p8-20020a056000018800b0034dc4c707camr4627516wrx.20.1714729060539;
        Fri, 03 May 2024 02:37:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001ec80dbb8b1sm2804169plh.73.2024.05.03.02.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 02:37:40 -0700 (PDT)
Message-ID: <48787c70-1abf-433e-ad3f-9e212237f9a5@suse.com>
Date: Fri, 3 May 2024 19:07:35 +0930
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org
References: <cover.1714722726.git.anand.jain@oracle.com>
 <6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com>
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
In-Reply-To: <6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/3 18:38, Anand Jain 写道:
> This patch, along with the dependent patches below, adds support for
> ext4 unwritten file extents as preallocated file extent in btrfs.
> 
>   btrfs-progs: convert: refactor ext2_create_file_extents add argument ext2_inode
>   btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file inode pointers
>   btrfs-progs: convert: refactor __btrfs_record_file_extent to add a prealloc flag
> 
> The patch is developed with POV of portability with the current
> e2fsprogs library.
> 
> Testcase:
> 
>       $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=1 conv=fsync status=none
>       $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=2 conv=fsync seek=1 status=none
>       $ xfs_io -f -c 'falloc -k 12K 12K' /mnt/test/foo
>       $ dd if=/dev/zero of=/mnt/test/foo bs=4K count=1 conv=fsync seek=6 status=none
> 
>       $ filefrag -v /mnt/test/foo
>       Filesystem type is: ef53
>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
> 	 ext:     logical_offset:        physical_offset: length:   expected: flags:
> 	   0:        0..       0:      33280..     33280:      1:
> 	   1:        1..       2:      33792..     33793:      2:      33281:
> 	   2:        3..       5:      33281..     33283:      3:      33794: unwritten
> 	   3:        6..       6:      33794..     33794:      1:      33284: last,eof
> 
>       $ sha256sum /mnt/test/foo
>       18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  /mnt/test/foo
> 
>     Convert and compare the checksum
> 
>     Before:
> 
>       $ filefrag -v /mnt/test/foo
>       Filesystem type is: 9123683e
>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>        ext:     logical_offset:        physical_offset: length:   expected: flags:
>        0:        0..       0:      33280..     33280:      1:             shared
>        1:        1..       2:      33792..     33793:      2:      33281: shared
>        2:        3..       6:      33281..     33284:      4:      33794: last,shared,eof
>       /mnt/test/foo: 3 extents found
> 
>       $ sha256sum /mnt/test/foo
>       6874a1733e5785682210d69c07f256f684cf5433c7235ed29848b4a4d52030e0  /mnt/test/foo
> 
>     After:
> 
>       $ filefrag -v /mnt/test/foo
>       Filesystem type is: 9123683e
>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
> 	 ext:     logical_offset:        physical_offset: length:   expected: flags:
> 	   0:        0..       0:      33280..     33280:      1:             shared
> 	   1:        1..       2:      33792..     33793:      2:      33281: shared
> 	   2:        3..       5:      33281..     33283:      3:      33794: unwritten,shared
> 	   3:        6..       6:      33794..     33794:      1:      33284: last,shared,eof
>       /mnt/test/foo: 4 extents found
> 
>       $ sha256sum /mnt/test/foo
>       18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  /mnt/test/foo
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC: Limited tested. Is there a ready file or test case available to
> exercise the feature?
> 
>   convert/source-fs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-
>   convert/source-fs.h |  1 +
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/convert/source-fs.c b/convert/source-fs.c
> index 9039b0e66758..647ea1f29060 100644
> --- a/convert/source-fs.c
> +++ b/convert/source-fs.c
> @@ -239,6 +239,45 @@ fail:
>   	return ret;
>   }
>   
> +int find_prealloc(struct blk_iterate_data *data, int index, bool *prealloc)

This function is called for every file extent we're going to create.
I'm not a big fan of doing so many lookup.

My question is, is this the only way to determine the flag of the data 
extent?

My instinct says there should be a straight forward way to determine if 
a file extent is preallocated or not, just like what we do in our file 
extent items.
Thus during the ext2fs_block_iterate2(), there should be some way to 
tell if a block is preallocated or not.

Thus adding ext4 ML to get some feedback.

Thanks,
Qu

> +{
> +	ext2_extent_handle_t handle;
> +	struct ext2fs_extent extent;
> +
> +	if (ext2fs_extent_open2(data->ext2_fs, data->ext2_ino,
> +				data->ext2_inode, &handle)) {
> +		error("ext2fs_extent_open2 failed, inode %d", data->ext2_ino);
> +		return -EINVAL;
> +	}
> +
> +	if (ext2fs_extent_goto2(handle, 0, index)) {
> +		error("ext2fs_extent_goto2 failed, inode %d num_blocks %llu",
> +		       data->ext2_ino, data->num_blocks);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	memset(&extent, 0, sizeof(struct ext2fs_extent));
> +	if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
> +		error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
> +		       data->ext2_ino);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	if (extent.e_pblk != data->disk_block) {
> +	error("inode %d index %d found wrong extent e_pblk %llu wanted disk_block %llu",
> +		       data->ext2_ino, index, extent.e_pblk, data->disk_block);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
> +		*prealloc = true;
> +
> +	return 0;
> +}
> +
>   /*
>    * Record a file extent in original filesystem into btrfs one.
>    * The special point is, old disk_block can point to a reserved range.
> @@ -257,6 +296,7 @@ int record_file_blocks(struct blk_iterate_data *data,
>   	u64 old_disk_bytenr = disk_block * sectorsize;
>   	u64 num_bytes = num_blocks * sectorsize;
>   	u64 cur_off = old_disk_bytenr;
> +	int index = data->first_block;
>   
>   	/* Hole, pass it to record_file_extent directly */
>   	if (old_disk_bytenr == 0)
> @@ -276,6 +316,12 @@ int record_file_blocks(struct blk_iterate_data *data,
>   		u64 extent_num_bytes;
>   		u64 real_disk_bytenr;
>   		u64 cur_len;
> +		bool prealloc = false;
> +
> +		if (find_prealloc(data, index, &prealloc)) {
> +			data->errcode = -1;
> +			return -EINVAL;
> +		}
>   
>   		key.objectid = data->convert_ino;
>   		key.type = BTRFS_EXTENT_DATA_KEY;
> @@ -317,11 +363,12 @@ int record_file_blocks(struct blk_iterate_data *data,
>   		ret = btrfs_record_file_extent(data->trans, data->root,
>   					data->objectid, data->inode, file_pos,
>   					real_disk_bytenr, cur_len,
> -					false);
> +					prealloc);
>   		if (ret < 0)
>   			break;
>   		cur_off += cur_len;
>   		file_pos += cur_len;
> +		index++;
>   
>   		/*
>   		 * No need to care about csum
> diff --git a/convert/source-fs.h b/convert/source-fs.h
> index 0e71e79eddcc..3922c444de10 100644
> --- a/convert/source-fs.h
> +++ b/convert/source-fs.h
> @@ -156,5 +156,6 @@ int read_disk_extent(struct btrfs_root *root, u64 bytenr,
>   		            u32 num_bytes, char *buffer);
>   int record_file_blocks(struct blk_iterate_data *data,
>   			      u64 file_block, u64 disk_block, u64 num_blocks);
> +int find_prealloc(struct blk_iterate_data *data, int index, bool *prealloc);
>   
>   #endif

