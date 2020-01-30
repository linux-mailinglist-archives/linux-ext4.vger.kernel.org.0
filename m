Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECF814D95C
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jan 2020 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgA3Kz4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jan 2020 05:55:56 -0500
Received: from othala.iewc.co.za ([154.73.34.78]:35106 "EHLO othala.iewc.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3Kzz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Jan 2020 05:55:55 -0500
Received: from [165.16.203.62] (helo=tauri.local.uls.co.za)
        by othala.iewc.co.za with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1ix7Tw-0008Uv-9c; Thu, 30 Jan 2020 12:55:32 +0200
Received: from [192.168.42.209]
        by tauri.local.uls.co.za with esmtp (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1ix7Tq-0000nt-9B; Thu, 30 Jan 2020 12:55:31 +0200
Subject: Re: e2fsck fails with unable to set superblock
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
 <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
 <90b76473-8ca5-e50a-6c8c-31ea418df7ed@uls.co.za>
 <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
 <57CCDA98-4334-469B-B6D8-364417E69423@dilger.ca>
 <61127f04-96bf-58ff-983d-f4b87b7d88f8@uls.co.za>
 <50b83755-3c24-ceff-2529-c89ef4df363b@uls.co.za>
 <7cf0c5cc-7679-41f4-c8e4-e6d79cb88d5f@uls.co.za>
 <20200129205049.GA303030@mit.edu>
From:   Jaco Kroon <jaco@uls.co.za>
Autocrypt: addr=jaco@uls.co.za; prefer-encrypt=mutual; keydata=
 mQENBFXtplYBCADM6RTLCOSPiclevkn/gdf8h9l+kKA6N+WGIIFuUtoc9Gaf8QhXWW/fvUq2
 a3eo4ULVFT1jJ56Vfm4MssGA97NZtlOe3cg8QJMZZhsoN5wetG9SrJvT9Rlltwo5nFmXY3ZY
 gXsdwkpDr9Y5TqBizx7DGxMd/mrOfXeql57FWFeOc2GuJBnHPZQMJsQ66l2obPn36hWEtHYN
 gcUSPH3OOusSEGZg/oX/8WSDQ/b8xz1JKTEgcnu/JR0FxzjY19zSHmbnyVU+/gF3oeJFcEUk
 HvZu776LRVdcZ0lb1bHQB2K9rTZBVeZLitgAefPVH2uERVSO8EZO1I5M7afV0Kd/Vyn9ABEB
 AAG0G0phY28gS3Jvb24gPGphY29AdWxzLmNvLnphPokBNwQTAQgAIQUCVe2mVgIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAILcSxr/fungCPB/sHrfufpRbrVTtHUjpbY4bTQLQE
 bVrh4/yMiKprALRYy0nsMivl16Q/3rNWXJuQ0gR/faC3yNlDgtEoXx8noXOhva9GGHPGTaPT
 hhpcp/1E4C9Ghcaxw3MRapVnSKnSYL+zOOpkGwye2+fbqwCkCYCM7Vu6ws3+pMzJNFK/UOgW
 Tj8O5eBa3DiU4U26/jUHEIg74U+ypYPcj5qXG0xNXmmoDpZweW41Cfo6FMmgjQBTEGzo9e5R
 kjc7MH3+IyJvP4bzE5Paq0q0b5zZ8DUJFtT7pVb3FQTz1v3CutLlF1elFZzd9sZrg+mLA5PM
 o8PG9FLw9ZtTE314vgMWJ+TTYX0kuQENBFXtplYBCADedX9HSSJozh4YIBT+PuLWCTJRLTLu
 jXU7HobdK1EljPAi1ahCUXJR+NHvpJLSq/N5rtL12ejJJ4EMMp2UUK0IHz4kx26FeAJuOQMe
 GEzoEkiiR15ufkApBCRssIj5B8OA/351Y9PFore5KJzQf1psrCnMSZoJ89KLfU7C5S+ooX9e
 re2aWgu5jqKgKDLa07/UVHyxDTtQKRZSFibFCHbMELYKDr3tUdUfCDqVjipCzHmLZ+xMisfn
 yX9aTVI3FUIs8UiqM5xlxqfuCnDrKBJjQs3uvmd6cyhPRmnsjase48RoO84Ckjbp/HVu0+1+
 6vgiPjbe4xk7Ehkw1mfSxb79ABEBAAGJAR8EGAEIAAkFAlXtplYCGwwACgkQCC3Esa/37p7u
 XwgAjpFzUj+GMmo8ZeYwHH6YfNZQV+hfesr7tqlZn5DhQXJgT2NF6qh5Vn8TcFPR4JZiVIkF
 o0je7c8FJe34Aqex/H9R8LxvhENX/YOtq5+PqZj59y9G9+0FFZ1CyguTDC845zuJnnR5A0lw
 FARZaL8T7e6UGphtiT0NdR7EXnJ/alvtsnsNudtvFnKtigYvtw2wthW6CLvwrFjsuiXPjVUX
 825zQUnBHnrED6vG67UG4z5cQ4uY/LcSNsqBsoj6/wsT0pnqdibhCWmgFimOsSRgaF7qsVtg
 TWyQDTjH643+qYbJJdH91LASRLrenRCgpCXgzNWAMX6PJlqLrNX1Ye4CQw==
Organization: Ultimate Linux Solutions (Pty) Ltd
Message-ID: <2b684e66-db83-cf9e-0ea2-a7620cef46c9@uls.co.za>
Date:   Thu, 30 Jan 2020 12:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129205049.GA303030@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Spam-report: Relay access (othala.iewc.co.za).
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On 2020/01/29 22:50, Theodore Y. Ts'o wrote:
> On Wed, Jan 29, 2020 at 06:35:41AM +0200, Jaco Kroon wrote:
>> Hi,
>>
>> Inode 181716301 block 33554947 conflicts with critical metadata,
>> skipping block checks.
>>
>> So the critical block stuff I'm guessing can be expected since a bunch
>> of those tree structures probably got zeroed too.
> It's possible that this was caused by the tree structures getting
> written with garbage (33554947 is not zero, so it's not the extent
> tree structure getting zeroed, by definition).  If metadata checksums
> are enabled, then the kernel would notice (and flag them with EXT4-fs
> error reports) if extent trees were not correctly set up.
>
> Another possibility is that hueristics you used for guessing how to
> recontrust the block group discripts were incorrectly.  Note that if
> the file system has been grown, using on-line or off-line resize2fs,
> the results may not be identical to how the block groups laid out by
> mke2fs would have done things.  So trying to use the existing pattern
> of block group descriptors to reconstruct missing ones is fraught with
> potential problems.
So my code did some extra work in that it regenerated existing ones too,
and the only issues it picked up was with those GDs which was "all
zero".  So I'm fairly confident that it's OK what I've done.  The
descriptions on the links I've previously posted made more and more
sense as I re-read them a few times and were spot on with what was found
on disk for non-damaged GDT blocks.  Other than bg_flags ... which
Andreas explained quite well.
>
> If the file system has never been resized, and if you have exactly the
> same version of e2fsprogs used to initially create the file system,
> and if you have the exact same version of /etc/mke2fs.conf, and the
> exact same command-line options to mke2fs, you might be able to use
> "mke2fs -S" (see the mke2fs manpage) to rewrite the superblock and
> block group descriptors.  But if any of the listed assumptions can't
> be assured, it's a dangerous thing to do.

It has, a few times, always online.  Generally in increments of 1TB at a
time. I can't remember all the arguments and stuff though, and I have
definitely upgraded e2fsprogs in the meantime.

Hehehe, dangerous at this point in time is an option compared to
reformatting and definitely losing all the data I can only win.  And LVM
snapshots are helpful w.r.t. being able to roll back, but it can't get
worse than "complete data loss" which is where I'm currently at.

>
>> Another idea is to use debugfs to mark inode 181716301 as deleted, but
>> I'm not sure that's safe at this stage?
> Well, you'll lose whatever was in that inode, but it's more likely
> that the problem is that if the block group descriptors are incorret,
> you'll cause even more damage.
>
> Did you make a full image backup of the good disks you can revert any
> experiments that you might try?

LVM snapshot yes.  Don't have 85T just lying around elsewhere to dd onto.

>
> Good look,
>
> 					- Ted
>
> P.S.  For future reference, please take a look at the man page of
> e2image for how you can back up the ext4's critical metadata blocks.
>
This is great!  I'll definitely add that to my bag of tricks. 
Especially for this particular server which houses most of our backups
for other hosts.

Kind Regards,
Jaco

