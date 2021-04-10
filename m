Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599DA35A9ED
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 03:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhDJBYj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 21:24:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47266 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235319AbhDJBYi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 21:24:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13A1OKeh011017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 21:24:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0EA2015C3B12; Fri,  9 Apr 2021 21:24:20 -0400 (EDT)
Date:   Fri, 9 Apr 2021 21:24:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH 2/2] ext4: Annotate data race in
 jbd2_journal_dirty_metadata()
Message-ID: <YHD+Q4NdOQ7j7doW@mit.edu>
References: <20210406161605.2504-1-jack@suse.cz>
 <20210406161804.20150-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406161804.20150-2-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 06, 2021 at 06:18:00PM +0200, Jan Kara wrote:
> Assertion checks in jbd2_journal_dirty_metadata() are known to be racy
> but we don't want to be grabbing locks just for them.  We thus recheck
> them under b_state_lock only if it looks like they would fail. Annotate
> the checks with data_race().
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
