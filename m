Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD04A372CD8
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhEDPTy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 11:19:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56226 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230254AbhEDPTx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 11:19:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 144FIqrY015598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 May 2021 11:18:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F04D415C3C43; Tue,  4 May 2021 11:18:51 -0400 (EDT)
Date:   Tue, 4 May 2021 11:18:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        harshads@google.com
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJFl2ydURsg3Ec/c@mit.edu>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 12:29:21AM -0600, Andreas Dilger wrote:
> > @@ -344,10 +361,10 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
> > 						offsetof(struct ext4_fc_tail,
> > 						fc_crc));
> > 			jbd_debug(1, "tail tid %d, expected %d\n",
> > -					le32_to_cpu(tail->fc_tid),
> > +					get_le32(&tail->fc_tid),
> > 					expected_tid);
> > -			if (le32_to_cpu(tail->fc_tid) == expected_tid &&
> > -				le32_to_cpu(tail->fc_crc) == state->fc_crc) {
> > +			if (get_le32(&tail->fc_tid) == expected_tid &&
> > +				get_le32(&tail->fc_crc) == state->fc_crc) {
> 
> (style) better to align continued line after '(' on previous line?  That way
> it can be distinguished from the next (body) line more easily

Thanks, I fixed up the whitespace style issues (which were in the
original code, but while we're modifying these lines, might as well
fix them up).

					- Ted
