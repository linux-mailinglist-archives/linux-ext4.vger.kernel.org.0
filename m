Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9F73E720
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFZSAk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFZSA2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 14:00:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D845610C9
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 11:00:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35QI01pl012859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 14:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687802403; bh=zp6bgmD+pQdBOIfD/xBKFnjBHHFQihNU5r8ETTx12/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iuDm7KF+mVBB4610o2j432w6NByftq8xk0pn7KTs3dQ66y8zZf6BPKlafAe+F2dht
         ZO9zZj5vSr42Qt9u3v95VuT+fySLRVsPuuJtqO0EtYPdEe/2AzwBsQhTeEpXunS2QZ
         ueFu4/M92GBaIsN9zIZAKdnjzYJhvQGlAwTo2n++Y1XCTkH+Z/Jq7ocDekYF9I7Aw2
         Tu44ncEe2ZgiaruwqSnltdDUiVp++mdePb03eNqa4Sl2y4PwsXZBMJBrJUWdYqJBg3
         uFoJmWsJcONosImf4O2RrG1B54+86zhjFt4J/zlpwCSP+1LWTpKJcUufRPLpeGnw++
         hAITC9NvgHbvw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 23B3115C027E; Mon, 26 Jun 2023 14:00:01 -0400 (EDT)
Date:   Mon, 26 Jun 2023 14:00:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: mkfs.ext4 failed when orphan_file is enabled
Message-ID: <20230626180001.GA225716@mit.edu>
References: <3f0c3d5c-3dbf-6e9e-962b-616016c7427e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0c3d5c-3dbf-6e9e-962b-616016c7427e@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 26, 2023 at 08:48:23PM +0800, Kemeng Shi wrote:
> Hi all, I find that "kvm-xfstests -c ext4/1k ext4/049" is failed on
> current dev branch because of mkfs.ext4 failure.

Hmm, I'm not seeing this mkfs.ext4 failure using 1.47.0.  I have two
cherry-picks on top of 1.47, but neither relate to mkfs.ext4:

  24a11cc371a4 ("e2fsck: Suppress "orphan file is clean" message in preen mode")

and

  8798bbb81687 ("e2fsck: fix handling of a invalid symlink in an inline_data directory")

See:

root@kvm-xfstests:~# /sbin/mkfs.ext4  -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/vdc
mke2fs 1.47.0 (5-Feb-2023)
/dev/vdc contains a ext4 file system
        last mounted on /vdc on Sun Jun 25 22:14:30 2023
Discarding device blocks: done                            
Creating filesystem with 1310720 4k blocks and 1280 inodes
Filesystem UUID: 127d490e-6caa-45cf-b5da-5616c5564a1a
Superblock backups stored on blocks: 
        8192, 24576, 40960, 57344, 73728, 204800, 221184, 401408, 663552, 
        1024000

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done   

Can you confirm what version of e2fsprogs you are using?  Is it
exactly 1.47.0, or do you have some additional commits (either from
the upstream master or maint branches) applied?

> I also try this on my host machine with old version mke2fs. The orphan_file
> feature is not set in old version /etc/mke2fs.conf and the mkfs.ext4 works
> fine.
> 
> It's likely orphan_file is not supported by old version.

That's correct.

						- Ted

						
