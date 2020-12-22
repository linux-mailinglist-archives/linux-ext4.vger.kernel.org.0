Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8839A2E0E24
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgLVSOX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 13:14:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45225 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728088AbgLVSOW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 13:14:22 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BMIDL4d014934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 13:13:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 00951420280; Tue, 22 Dec 2020 13:13:20 -0500 (EST)
Date:   Tue, 22 Dec 2020 13:13:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9043030c040ce1849a60@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in ext4_commit_super
Message-ID: <X+I3QEL7gxO/YljX@mit.edu>
References: <0000000000001faff305b709b8ad@google.com>
 <20201222100908.1782-1-hdanton@sina.com>
 <20201222112853.GF13601@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222112853.GF13601@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 22, 2020 at 12:28:53PM +0100, Jan Kara wrote:
> > Fix e810c942a325 ("ext4: save error info to sb through journal if available")
> > by flushing work as part of rollback.
> 
> Thanks for having a look. I don't think the fix is quite correct though. The
> flush_work() should be at failed_mount3: label. So something like attached
> fixup. Ted, can you please fold it into the buggy commit?

Done.  I folded it into "ext4: defer saving error info from atomic
context" since this is the commit where we introduced the s_error_work
workqueue.

Thanks!!

						- Ted
