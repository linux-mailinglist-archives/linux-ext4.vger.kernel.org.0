Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B297A409C
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Aug 2019 00:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfH3Wet (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Aug 2019 18:34:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49158 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728143AbfH3Wet (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Aug 2019 18:34:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7UMYfOd001455
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 18:34:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9CBBB42049E; Fri, 30 Aug 2019 18:34:41 -0400 (EDT)
Date:   Fri, 30 Aug 2019 18:34:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+0bf8ddafbdf2c46eb6f3@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ODEBUG bug in ext4_fill_super
Message-ID: <20190830223441.GA25380@mit.edu>
References: <0000000000006fc70605915ac6ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006fc70605915ac6ad@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz invalid

This has already been fixed in the latest linux-next

