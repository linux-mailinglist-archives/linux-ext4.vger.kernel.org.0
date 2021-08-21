Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811653F3872
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 06:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhHUEIB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 00:08:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57639 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229498AbhHUEIA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 00:08:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17L47GBa023484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Aug 2021 00:07:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C21F015C3DBB; Sat, 21 Aug 2021 00:07:16 -0400 (EDT)
Date:   Sat, 21 Aug 2021 00:07:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot+13146364637c7363a7de@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix race writing to an inline_data file while its
 xattrs are changing
Message-ID: <YSB79Lt77EpxHTnl@mit.edu>
References: <000000000000e5080305c9e51453@google.com>
 <20210821035427.1471851-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821035427.1471851-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git 9e445093e523f3277081314c864f708fd4bd34aa

