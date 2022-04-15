Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34725030A4
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Apr 2022 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354091AbiDOV2U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Apr 2022 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355499AbiDOV1p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Apr 2022 17:27:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC98E6C70
        for <linux-ext4@vger.kernel.org>; Fri, 15 Apr 2022 14:23:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23FLMp0E031975
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 17:22:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 88FAF15C3EAF; Fri, 15 Apr 2022 17:22:51 -0400 (EDT)
Date:   Fri, 15 Apr 2022 17:22:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: resize2fs on ext4 leads to corruption
Message-ID: <YlniK5dd1wV2bCXi@mit.edu>
References: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 16, 2022 at 12:37:29AM +1000, Peter Urbanec wrote:
> # e2fsck -f -C 0 -b 32768 -z /root/20220415_2015_e2fsck-b_32768.e2undo
> /dev/md0
> e2fsck 1.46.4 (18-Aug-2021)
> Overwriting existing filesystem; this can be undone using the command:
>      e2undo /root/20220415_2015_e2fsck-b_32768.e2undo /dev/md0
> 
> e2fsck: Undo file corrupt while trying to open /dev/md0
> 
> The superblock could not be read or does not describe a valid ext2/ext3/ext4
> filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>      e2fsck -b 8193 <device>
>   or
>      e2fsck -b 32768 <device>

So the failure of "e2fsck -f -C 0 -b 32768 -z /root/e2fsck.e2undo
/dev/md0" appears to be a bug where e2fsck doesn't work correctly with
an undo file when using a backup superblock.  I can replicate this
using these commands:

	mke2fs -q -t ext4 /tmp/foo.img 2G
	e2fsck -b 32768 -z /tmp/undo /tmp/foo.img

Running e2fsck without the -z option succeeds.  The combination of the
-b and -z option seems to be broken.  As a workaround, I would suggest
doing is to try running e2fsck with -n, which will open the block
device read-only, e.g. "e2fsck -b 32768 -n /dev/mdXX".  If the changes
e2fsck look safe, then you can run e2fsck without the -n option.


As far as what happens, I wasn't able to replicate the problem when
resizing an empty file system from 3906946560 to 5860419840 blocks,
using a 64-bit binary.  I've stopped testing 32-bit builds quite a
while ago, and filling the file system would take more time than I
have at the moment.  I will note that 3906946560 fits in 32-bits,
while 5860419840 is larger than 2**32.  So it could very much be some
kind of a 32-bit block number overflow.

For better or for worse, I don't have the resources or time to test
the full set of combinations of file system features, and as I
mentioned, I don't test 32-bit builds any more, either.  Enterprise
distributions will provide paid support, but they tend to only support
a limited number of file system features, and not the full set of
combination of features.

While I'm grateful that Gentoo users seem to be super adventurous in
terms of turning every single feature they can find, and then send in
bug reports so we can improve the case base --- there are reasons why
features like sparse_super2 and inline_data are not enabled by
default, and I feel bad when people turn on non-standard features, and
then lose data because they aren't doing backups and they enable
features that haven't received as much testing as the default
features.

So I don't know if the problemw as due to some kind of bug in
resize2fs caused by the use of 64-bit block numbers on a 32-bit
binary, or due to the enablement of the sparse_super2 feature.  But
for now, let's see if we can get recover your file system, hopefully
with minimal data loss.  And since the using an undo file seems to be
problematic with running e2fsck -b, the alternatives are (a) do a full
block level backup of the file system before running e2fsck --- which
I know will be hard since this is a very large file system, and (b)
using e2fsck -n first and looking at what e2fsck would do first.

I will look at why "e2fsck -b 32768 -z /tmp/foo.undo /tmp/foo.img"
fails, but I may not get to it in a week or two.

Cheers,

						- Ted





