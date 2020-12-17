Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704602DD4BC
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgLQQAW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 11:00:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56686 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727566AbgLQQAV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 11:00:21 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BHFxWSi013031
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 10:59:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9CDE6420280; Thu, 17 Dec 2020 10:59:32 -0500 (EST)
Date:   Thu, 17 Dec 2020 10:59:32 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 5/8] ext4: Use sbi instead of EXT4_SB(sb) in
 ext4_update_super()
Message-ID: <X9uAZEA+DGYmq4OE@mit.edu>
References: <20201216101844.22917-1-jack@suse.cz>
 <20201216101844.22917-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216101844.22917-6-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 16, 2020 at 11:18:41AM +0100, Jan Kara wrote:
> No behavioral change.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
