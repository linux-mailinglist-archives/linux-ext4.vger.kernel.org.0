Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4ABF128C57
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Dec 2019 03:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLVChq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Dec 2019 21:37:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52750 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbfLVChp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Dec 2019 21:37:45 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBM2beTG005325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Dec 2019 21:37:40 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1659B420822; Sat, 21 Dec 2019 21:37:40 -0500 (EST)
Date:   Sat, 21 Dec 2019 21:37:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Paul Richards <paul.richards@gmail.com>
Subject: Re: [PATCH] ext4: Clarify impact of 'commit' mount option
Message-ID: <20191222023740.GB108990@mit.edu>
References: <20191218111210.14161-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218111210.14161-1-jack@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 18, 2019 at 12:12:10PM +0100, Jan Kara wrote:
> The description of 'commit' mount option dates back to ext3 times.
> Update the description to match current meaning for ext4.
> 
> Reported-by: Paul Richards <paul.richards@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
