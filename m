Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBCC504E6B
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiDRJgY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiDRJgY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 05:36:24 -0400
Received: from mail.urbanec.net (mail.urbanec.net [218.214.117.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BF1658E
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urbanec.net
        ; s=dkim_rsa; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
        :Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EJd7Kz9TCAFVHQKPMHNYLf3iJTffkjY2OB9PTVMcEP8=; i=@urbanec.net; t=1650274423
        ; x=1651138423; b=BghvkRvjknIcfL+6nVEZu7270c9aHzf+jR+6TbRsNlowOrGELDE6FVkLxkU
        812Q+EAYLgRw84ukHzbdTbCqfNNl8FLtaeRg1gDdEatwMMDQBGQytDB0WUUP0j+/ZpTmme+ERjsKx
        U3H01Rue3SacA2d0fkA4Y/twUawWRQqOfo1CQ4eOuonlAgfeSZezcO/Y48eZDaT8ptxDxvBZodTvE
        1INJJJJ6w3f3tkZvzAsAQfPyI3q/y4kWIyli++dk59ir/Tk8TO4TleA3A9Uur32KNy4b7gUShfiNr
        tccalIObJOu0Jw4z0rpNYEla0V1sug8ruEQM3JjqhAH+lYaUofjQ==;
Received: from ten.urbanec.net ([192.168.42.10])
        by mail.urbanec.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux-ext4.vger.kernel.org@urbanec.net>)
        id 1ngNlK-0000ND-T8; Mon, 18 Apr 2022 19:33:38 +1000
Message-ID: <f398b938-c7bb-e1f7-2843-86b0adaff4e4@urbanec.net>
Date:   Mon, 18 Apr 2022 19:33:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
Subject: Re: resize2fs on ext4 leads to corruption
Content-Language: en-AU
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
 <YlniK5dd1wV2bCXi@mit.edu>
In-Reply-To: <YlniK5dd1wV2bCXi@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

First, thank you for your help with this. I finally managed to get some 
time today to take another look.

On 16/04/2022 07:22, Theodore Ts'o wrote:
> As a workaround, I would suggest
> doing is to try running e2fsck with -n, which will open the block
> device read-only, e.g. "e2fsck -b 32768 -n /dev/mdXX".  If the changes
> e2fsck look safe, then you can run e2fsck without the -n option.

First I updated e2fsprogs to 1.46.5 and then tried:

# e2fsck -f -C 0 -b 32768 -n /dev/md0
e2fsck 1.46.5 (30-Dec-2021)
Pass 1: Checking inodes, blocks, and sizes
Error reading block 32 (Attempt to read block from filesystem resulted 
in short read).  Ignore error? no

e2fsck: aborted

Initially things looked promising and there were no errors being 
reported even at 47% of the way through the check. The check terminated 
at approximately the 50% mark with what appears to be a 32-bit overflow 
issue.

Looking at the code shows that the `block` member of `struct_io_channel` 
has a type of `unsigned long`, which is 4 bytes on a 32-bit system. As a 
result, `e2fsck_handle_(read|write)_error()` can not actually handle 
blocks past the 32-bit limit. `e2fsck_handle_read_error()` is called via 
`channel->read_error()` from `raw_read_blk()` in `unix_io.c`. That 
function uses `unsigned long long` for `block`. I have not looked 
closely enough to determine whether the 32-bit overflow will only be an 
issue when the error handler is invoked.

Ideally, the `block` member of `struct_io_channel` would be of type 
`unsigned long long`, but changing this may introduce binary 
compatibility issues. As an alternative, it may be prudent to perform an 
early check for the total number of blocks in a file system and refuse 
to run e2fsck (and other tools) if that number would cause an overflow.

I have not followed the code any further to see what may have happened 
during resize2fs.

> As far as what happens, I wasn't able to replicate the problem when
> resizing an empty file system from 3906946560 to 5860419840 blocks,
> using a 64-bit binary.  I've stopped testing 32-bit builds quite a
> while ago

If it is helpful, I can run some ad-hoc tests on the affected 32-bit 
system, now with e2fsprogs 1.46.5. I've got enough free space to create 
about ~2TB file for testing purposes. If that is enough for an empty 
test file system, please let me know the sequence of test commands and 
I'll provide the results.

> 3906946560 fits in 32-bits, while 5860419840 is larger than 2**32.
> So it could very much be some kind of a 32-bit block number overflow.

It almost certainly there is at least some aspect that is related to 
32-bit overflows. For that reason I'm not going to test my luck running 
anything that would further modify this file system on the 32-bit 
installation. I'm in the process of building a 64-bit system and will 
transplant the HDDs to this new machine. The plan is to go with kernel 
5.17.3 + e2fsprogs 1.46.5 and try the above `e2fsck -n` command to see 
if I have more luck on a 64-bit host.


> While I'm grateful that Gentoo users seem to be super adventurous in
> terms of turning every single feature they can find, and then send in
> bug reports so we can improve the case base --- there are reasons why
> features like sparse_super2 and inline_data are not enabled by
> default

Indeed, Gentoo tends to attract people who read man pages while tweaking 
all the options, rather than go with defaults. I can't speak for others, 
but in my case, when I created the file system, I systematically went 
though the documented options and turned on anything that looked like it 
would be applicable to the expected use case for the file system. I 
tried to stay away from options that were documented as not robust, for 
example `bigalloc`. I suppose it's a bit like premature optimisation - I 
should have left most things at default values and only start making 
changes if/when the need arises.

I should probably rethink my storage strategy. I certainly need to move 
from 32-bit to 64-bit, the hardware is capable. One big ext4 file system 
directly on top of md-raid5 has served me well for two decades. Maybe 
that is no longer a smart option when that one file system has grown to 
24TB.

> So I don't know if the problemw as due to some kind of bug in
> resize2fs caused by the use of 64-bit block numbers on a 32-bit
> binary, or due to the enablement of the sparse_super2 feature.

I used `dd` to made copies of superblocks 1 and 32768. I could not use 
`dd` to get a copy of superblock 5860392960 - maybe another case of a 
32-bit limit.

A quick hexdump comparison of superblocks 1 and 32768 shows that 
superblock 1 has been zeroed out and only a few fields have been 
repopulated with values that match superblock 32768. It also appears 
that the checksum has been recomputed using the empty fields as it 
differs between the two superblocks.

It looks like only the following fields have values set in superblock 1:
   s_inodes_count         = 00 E0 A9 2B
   s_blocks_count_lo      = 00 E9 4E 5D
   s_free_blocks_count_lo = CF C0 B0 8F
   s_free_inodes_count    = 47 DF F7 2A
   s_wtime                = 62 24 00 00
   s_state                = 01 00
   s_blocks_count_hi      = 01 00 00 00
   s_kbytes_written       = 20 9E 25 4F 00 00 00 00
   s_backup_bgs[1]        = 9D BA 02 00

superblock 1 only has a value in s_backup_bgs[1] whereas superblock 
32768 has both values set:
   s_backup_bgs[0]        = 01 00 00 00
   s_backup_bgs[1]        = 9D BA 02 00

A spot check of the `s_blocks_count_(lo|hi)` values indicates the 
correct size in 64-bit number of 4k blocks.

If it will help, I can supply these two superblocks.


> alternatives are (a) do a full
> block level backup of the file system before running e2fsck --- which
> I know will be hard since this is a very large file system

I could probably scrounge up enough old HDDs and SATA controllers to 
concatenate a non-redundant 16TB volume, but I don't have enough gear to 
stretch it to 24TB.

Once I transplant the drives to a 64-bit machine, is there a way I could 
use e2image to create a file that I can use to test whether an e2fsck 
run will work?

Thank you,

	Peter
