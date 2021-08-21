Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7593F3870
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 06:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhHUEER (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 00:04:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57207 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229498AbhHUEEP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 00:04:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17L43Cg6022336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Aug 2021 00:03:14 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 735C915C3DBB; Sat, 21 Aug 2021 00:03:12 -0400 (EDT)
Date:   Sat, 21 Aug 2021 00:03:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, bvanassche@acm.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in ext4_write_inline_data
Message-ID: <YSB7AENonC6a0rCH@mit.edu>
References: <000000000000dc107905c99b8e53@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000dc107905c99b8e53@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git 9e445093e523f3277081314c864f708fd4bd34aa
