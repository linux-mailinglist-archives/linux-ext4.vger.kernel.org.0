Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D86F2B87
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 01:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjD3X3H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 19:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjD3X3H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 19:29:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783E2183
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 16:29:04 -0700 (PDT)
Received: from letrec.thunk.org ([216.250.210.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UNSmre008397
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 19:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682897338; bh=Qo4pKrdIiRKoB2Q0zHTwoPbMxDyuxD6ZK4kjONCoNgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Aw657uuNbYdUGVZfon+v2YwAe8MuZgKs3bif8yXCdAByunXQXThuD7CxEpllRT5Z1
         idoRYmZYe6s6Q0Ogbffug0CXBDe/PbySEVFn644YybgClvpvtPISLQCP+gqucc2oIH
         LCL68/Hgy6yILyLpnFka7M5KY/53UByGUZjuen18F8wP+Bb+/pX7pXuDvtjBCJcz0W
         sjnMigxMz6bOFV++V7GNL7ODo28jPi2hfjNtiEXgzn37RjfOKDmzSd2qlxpj9WRB6k
         FOLATe0IFF5MWfIKkSNR4LL32DQA5tW0Tgnfef5iEnviHGuchERjY5cBEvIbj47kCp
         wXTMGCiR1Da4Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 4D4008C02D7; Sun, 30 Apr 2023 19:28:46 -0400 (EDT)
Date:   Sun, 30 Apr 2023 19:28:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+9543479984ae9e576000@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in ext4_bmap
Message-ID: <ZE75rrngOl4FxEpF@mit.edu>
References: <000000000000967c2805e5b5d4ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000967c2805e5b5d4ed@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 08, 2022 at 12:33:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177eb001080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=9543479984ae9e576000
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

#syz fix: ext4, jbd2: add an optimized bmap for the journal inode
