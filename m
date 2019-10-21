Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F79DF741
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 23:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJUVFK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 17:05:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57395 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbfJUVFK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 17:05:10 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LL55ff018674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 17:05:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A14C6420456; Mon, 21 Oct 2019 17:05:05 -0400 (EDT)
Date:   Mon, 21 Oct 2019 17:05:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 17/22] jbd2: Drop jbd2_space_needed()
Message-ID: <20191021210505.GB24015@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-17-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-17-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:06:03AM +0200, Jan Kara wrote:
> The function is now just a trivial wrapper returning
> journal->j_max_transaction_buffers. Drop it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Assuming that we still need to do patch #16 (see my previous review
about my questions about what value it adds), this makes sense.

Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

