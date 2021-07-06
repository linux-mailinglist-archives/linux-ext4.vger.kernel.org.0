Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEED3BDDF5
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGFTXK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 15:23:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45102 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231773AbhGFTXI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 15:23:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 166JKL7Z013101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 15:20:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6EFB115C3CC6; Tue,  6 Jul 2021 15:20:21 -0400 (EDT)
Date:   Tue, 6 Jul 2021 15:20:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Gruber <j4n6ru@gmail.com>
Cc:     adilger.kernel@dilger.ca, trivial@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix comments and spaces to follow coding style
Message-ID: <YOSs9Qu1YpvPAP6v@mit.edu>
References: <20210706183900.310975-1-j4n6ru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706183900.310975-1-j4n6ru@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 06, 2021 at 08:39:00PM +0200, Jan Gruber wrote:
> This commit addresses two whitespace issues as well as
> instances of the following coding style issue regarding
> block comments, which were identified by checkpatch.pl:
> 
> "WARNING: Block comments use a trailing */ on a separate line"
> 
> The changes aim at making the code more pleasant to read
> and to eliminate warnings
> 
> Signed-off-by: Jan Gruber <j4n6ru@gmail.com>

Please don't send "checkpatch.pl --file" patches for the ext4 file
system; if you must, please focus on files in the drivers directory,
where they are more welcome.  If developers are making changes to a
file, fixing some checkpatch.pl whines is fine, but white-sapace only
changes just obfuscates "git blame" code archology, and so the costs
far outwieghs the costs.  "Fix" is also not the right verb to use.
For more information please see [1].

[1] https://gist.github.com/17twenty/8154928

If you are looking for subtantive ways of contributing to the ext4
file system, feel free to look at various syzbot warnings[2] and try
to figure out what is going on there.

[2] https://syzkaller.appspot.com/upstream

(In some cases, the syzbot complaint has already been fixed, and it's
just a matter of letting syzbot knoww that it has since been fixed by
a particular commit.  See [3] for more details.)

[3] https://github.com/google/syzkaller/blob/master/docs/syzbot.md

Cheers,

						- Ted
