Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EBED806
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 04:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfKDDWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Nov 2019 22:22:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54732 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728643AbfKDDWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Nov 2019 22:22:22 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA43MEjq007059
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Nov 2019 22:22:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 38BA7420311; Sun,  3 Nov 2019 22:22:12 -0500 (EST)
Date:   Sun, 3 Nov 2019 22:22:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     Xiaohui1 Li =?utf-8?B?5p2O5pmT6L6J?= <lixiaohui1@xiaomi.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFp?= =?utf-8?B?bF1SZTo=?=
 [PATCH v3 09/13] ext4: fast-commit commit path changes
Message-ID: <20191104032212.GA12046@mit.edu>
References: <1571900042725.99617@xiaomi.com>
 <20191024201800.GE1124@mit.edu>
 <1572349386604.43878@xiaomi.com>
 <20191029213553.GD4404@mit.edu>
 <1572409673853.43507@xiaomi.com>
 <20191030142628.GA16197@mit.edu>
 <CAAJeciVYOAWzsjAtL7SNmpFQH60z0MB53OPE3hZ==_oBB0N3dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJeciVYOAWzsjAtL7SNmpFQH60z0MB53OPE3hZ==_oBB0N3dQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 04, 2019 at 09:01:28AM +0800, xiaohui li wrote:
> 
> when in writeback mode, inode' data has not to be waited in jbd2
> thread, so the fsync time cost is also reduced.
> meawhile, writeback mode also can guarantee filesystem consistency in
> os crash-reboot conditions,
> with only one drawback is that it will cause security problems such as
> stale data will be seen.

It's not just stale data; in data=writeback, today if a file gets
deleted, its blocks are immediately eligible to be reused.  If there
is a crash before the transaction is committed, there could be a file
that would have deleted (and perhaps replaced) that doesn't in fact
get deleted, but its data blocks will have been corrupted.

I'm not fond of that particular behavior, and I may look to fix it,
but in general, data=writeback means that data blocks may be corrupted
or contain stale data after a crash --- for blocks that were freshly
created, or for a file that might have been deleted, but except for
the crash which means that the file deletion doesn't actually get
corrupted.

> but in android system with file encryption enabled, there is no
> security problem as files are all encryped.
> but user will see wrong file data in system crash-reboot conditions
> with writeback mode enabled.

If all files are encrypted, then yes, the chances of stale data
causing security issues is significantly reduced.

But see also the case of a file which is deleted immediately before a
crash.  Things are more complex in terms of the data gauarantees after
a crash, which is why data=ordered is the default.

Regards,

					- Ted
