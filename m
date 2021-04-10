Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8135A9EC
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 03:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhDJBY3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 21:24:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47231 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235319AbhDJBY3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 21:24:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13A1O9Z2010978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 21:24:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 61BAA15C3B12; Fri,  9 Apr 2021 21:24:09 -0400 (EDT)
Date:   Fri, 9 Apr 2021 21:24:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] ext4: Annotate data race in start_this_handle()
Message-ID: <YHD+OQ+Wi8XMl0Hp@mit.edu>
References: <20210406161605.2504-1-jack@suse.cz>
 <20210406161804.20150-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406161804.20150-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 06, 2021 at 06:17:59PM +0200, Jan Kara wrote:
> Access to journal->j_running_transaction is not protected by appropriate
> lock and thus is racy. We are well aware of that and the code handles
> the race properly. Just add a comment and data_race() annotation.
> 
> Reported-by: syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
