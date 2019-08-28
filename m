Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715FCA05ED
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2019 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1PPf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Aug 2019 11:15:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60799 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbfH1PPf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Aug 2019 11:15:35 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7SFF1IX007431
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:15:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9C53342049E; Wed, 28 Aug 2019 11:15:00 -0400 (EDT)
Date:   Wed, 28 Aug 2019 11:15:00 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2] ext4: fix potential use after free after remounting
 with noblock_validity
Message-ID: <20190828151500.GF24857@mit.edu>
References: <20190827120839.90454-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827120839.90454-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 27, 2019 at 08:08:39PM +0800, zhangyi (F) wrote:
> Remount process will release system zone which was allocated before if
> "noblock_validity" is specified. If we mount an ext4 file system to two
> mountpoints with default mount options, and then remount one of them
> with "noblock_validity", it may trigger a use after free problem when
> someone accessing the other one.
> 
>  # mount /dev/sda foo
>  # mount /dev/sda bar
> 
> User access mountpoint "foo"   |   Remount mountpoint "bar"
>                                |
> ext4_map_blocks()              |   ext4_remount()
> check_block_validity()         |   ext4_setup_system_zone()
> ext4_data_block_valid()        |   ext4_release_system_zone()
>                                |   free system_blks rb nodes
> access system_blks rb nodes    |
> trigger use after free         |
> 
> This problem can also be reproduced by one mountpint, At the same time,
> add_system_zone() can get called during remount as well so there can be
> racing ext4_data_block_valid() reading the rbtree at the same time.
> 
> This patch add RCU to protect system zone from releasing or building
> when doing a remount which inverse current "noblock_validity" mount
> option. It assign the rbtree after the whole tree was complete and
> do actual freeing after rcu grace period, avoid any intermediate state.
> 
> Reported-by: syzbot+1e470567330b7ad711d5@syzkaller.appspotmail.com
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks!

						- Ted
