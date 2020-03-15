Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12089185E89
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Mar 2020 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgCOQng (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Mar 2020 12:43:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50703 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728682AbgCOQng (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Mar 2020 12:43:36 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02FGhWdc029691
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Mar 2020 12:43:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 071D6420EBA; Sun, 15 Mar 2020 12:43:32 -0400 (EDT)
Date:   Sun, 15 Mar 2020 12:43:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/7] tests: Modify f_large_dir test to excercise indexed
 dir handling
Message-ID: <20200315164332.GS225435@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101602.29096-6-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 11:16:00AM +0100, Jan Kara wrote:
> Modify f_large_dir test to create indexed directory and create entries
> in it. That way the new code in ext2fs_link() for addition of entries
> into indexed directories gets executed including various special cases
> when growing htree.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
