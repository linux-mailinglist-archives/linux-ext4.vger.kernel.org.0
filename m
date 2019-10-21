Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3CDF448
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfJURaz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 13:30:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56612 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbfJURaz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 13:30:55 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LHUoxg005488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 13:30:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B32E2420458; Mon, 21 Oct 2019 13:30:50 -0400 (EDT)
Date:   Mon, 21 Oct 2019 13:30:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 13/22] jbd2: Drop pointless check from jbd2_journal_stop()
Message-ID: <20191021173050.GF27850@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-13-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-13-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:05:59AM +0200, Jan Kara wrote:
> If a transaction is larger than journal->j_max_transaction_buffers, that
> is a bug and not a trigger for transaction commit. Also the very next
> attempt to start new handle will start transaction commit anyway. So
> just remove the pointless check. Arguably, we could start transaction
> commit whenever the transaction size is *close* to
> journal->j_max_transaction_buffers. This has a potential to reduce
> latency of the next jbd2_journal_start() at the cost of somewhat smaller
> transactions. However for this to have any effect, it would mean that
> there isn't someone already waiting in jbd2_journal_start() which means
> metadata load for the fs is pretty light anyway so probably this
> optimization is not worth it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good; feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
