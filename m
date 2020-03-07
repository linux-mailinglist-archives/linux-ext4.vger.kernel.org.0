Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7911117CFA5
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2020 19:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCGSwI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Mar 2020 13:52:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33619 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgCGSwH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Mar 2020 13:52:07 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 027Iq09W029801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Mar 2020 13:52:01 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C485A42045B; Sat,  7 Mar 2020 13:52:00 -0500 (EST)
Date:   Sat, 7 Mar 2020 13:52:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/7] e2fsck: Clarify overflow link count error message
Message-ID: <20200307185200.GD99899@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101602.29096-2-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 11:15:56AM +0100, Jan Kara wrote:
> When directory link count is set to overflow value (1) but during pass 4
> we find out the exact link count would fit, we either silently fix this
> (which is not great because e2fsck then reports the fs was modified but
> output doesn't indicate why in any way), or we report that link count is
> wrong and ask whether we should fix it (in case -n option was
> specified). The second case is even more misleading because it suggests
> non-trivial fs corruption which then gets silently fixed on the next
> run. Similarly to how we fix up other non-problems, just create a new
> error message for the case directory link count is not overflown anymore
> and always report it to clarify what is going on.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied with a fixup to to tests/f_many_subdirs/expect.1, thanks.

(Please remember run "make check" before commiting a change.)

		     	   	  - Ted
