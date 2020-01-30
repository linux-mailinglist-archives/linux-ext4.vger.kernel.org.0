Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161F314D95F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jan 2020 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgA3K4B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jan 2020 05:56:01 -0500
Received: from othala.iewc.co.za ([154.73.34.78]:35150 "EHLO othala.iewc.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3K4A (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Jan 2020 05:56:00 -0500
Received: from [165.16.203.62] (helo=tauri.local.uls.co.za)
        by othala.iewc.co.za with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1ix7UL-00005b-Lb; Thu, 30 Jan 2020 12:55:57 +0200
Received: from [192.168.42.209]
        by tauri.local.uls.co.za with esmtp (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1ix7UK-0000pn-HD; Thu, 30 Jan 2020 12:55:57 +0200
Subject: Re: *** SPAM *** Re: e2fsck fails with unable to set superblock
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
 <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
 <90b76473-8ca5-e50a-6c8c-31ea418df7ed@uls.co.za>
 <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
 <57CCDA98-4334-469B-B6D8-364417E69423@dilger.ca>
 <61127f04-96bf-58ff-983d-f4b87b7d88f8@uls.co.za>
 <50b83755-3c24-ceff-2529-c89ef4df363b@uls.co.za>
 <7cf0c5cc-7679-41f4-c8e4-e6d79cb88d5f@uls.co.za>
 <E995C6CF-FC2F-4079-AA27-81530C0AF489@dilger.ca>
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
Message-ID: <343464b1-ce97-1d4a-19d2-9101390ddc10@uls.co.za>
Date:   Thu, 30 Jan 2020 12:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <E995C6CF-FC2F-4079-AA27-81530C0AF489@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Spam-report: Relay access (othala.iewc.co.za).
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 2020/01/29 22:00, Andreas Dilger wrote:
> On Jan 28, 2020, at 9:35 PM, Jaco Kroon <jaco@uls.co.za> wrote:
>> Hi,
>>
>> Inode 181716301 block 33554947 conflicts with critical metadata,
>> skipping block checks.
>> Inode 181716301 block 524296 conflicts with critical metadata, skipping
>> block checks.
>> Inode 181716301 block 2 conflicts with critical metadata, skipping block
>> checks.
>> Inode 181716301 block 294 conflicts with critical metadata, skipping
>> block checks.
>> Inode 181716301 block 1247805839 conflicts with critical metadata,
>> skipping block checks.
>> Inode 181716301 block 288 conflicts with critical metadata, skipping
>> block checks.
>> Inode 181716301 block 103285040 conflicts with critical metadata,
>> skipping block checks.
>> Inode 181716301 block 872415232 conflicts with critical metadata,
>> skipping block checks.
>> Inode 181716301 block 2560 conflicts with critical metadata, skipping
>> block checks.
>> Inode 181716301 block 479199248 conflicts with critical metadata,
>> skipping block checks.
>> Inode 181716301 block 1006632963 conflicts with critical metadata,
>> skipping block checks.
> This inode is probably just random garbage.  Erase that inode with:
>
> debugfs -w -R "clri <181716301>" /dev/sdX
>
> There may be multiple such inodes with nearby numbers in the likely
> case that a whole block is corrupted.  There has been some discussion
> about the best way to handle such corruption of a whole inode table
> block, but nothing has been implemented in e2fsck yet.

crowsnest ~ # debugfs -w -R "clri <181716301>" /dev/lvm/home
debugfs 1.45.4 (23-Sep-2019)
/dev/lvm/home: Block bitmap checksum does not match bitmap while reading
allocation bitmaps
clri: Filesystem not open

-n sorts that out.

There were a few other inodes too, wiped them too, restarted fsck now.

>
>> So the critical block stuff I'm guessing can be expected since a bunch
>> of those tree structures probably got zeroed too.
>>
>> It got killed because it ran out of RAM (OOM killer), 32GB physical +
>> 16GB swap.  I've extended swap to 512GB now and restarted.  It's
>> probably overkill (I hope).
>>
>> Any ideas on what might be consuming the RAM like this?   Unfortunately
>> my scroll-back doesn't go back far enough to see what other inodes if
>> any are also affected.  I've restarted with 2>&1 | tee /var/tmp/fsck.txt
>> now.
>>
>> Happy to go hunting to look for possible optimization ideas here ...
>>
>> Another idea is to use debugfs to mark inode 181716301 as deleted, but
>> I'm not sure that's safe at this stage?
> Marking it "deleted" isn't really the right thing, since (AFAIR) that
> will just update the inode bitmap and possibly set the "i_dtime" field
> in the inode.  The "clri" command will zero out the inode, which erases
> all of the bad block allocation references for that inode.  This is no
> "loss" since the inode is already garbage.

Agreed and makes perfect sense.

Kind Regards,
Jaco

