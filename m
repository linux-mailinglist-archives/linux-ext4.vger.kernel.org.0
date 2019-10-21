Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E3DE1CB
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 03:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfJUBjx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Oct 2019 21:39:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44234 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbfJUBjx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Oct 2019 21:39:53 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9L1dmj8006253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Oct 2019 21:39:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 197A3420458; Sun, 20 Oct 2019 21:39:48 -0400 (EDT)
Date:   Sun, 20 Oct 2019 21:39:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/22] ext4: Use ext4_journal_extend() instead of
 jbd2_journal_extend()
Message-ID: <20191021013948.GG6799@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-6-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:05:52AM +0200, Jan Kara wrote:
> Use ext4 helper ext4_journal_extend() instead of opencoding it in
> ext4_try_to_expand_extra_isize().
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good; you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

