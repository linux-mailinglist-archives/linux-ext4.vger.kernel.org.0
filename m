Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842932DD498
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLQPvV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 10:51:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55351 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728052AbgLQPvU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 10:51:20 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BHFoSqR009922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 10:50:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 44945420280; Thu, 17 Dec 2020 10:50:28 -0500 (EST)
Date:   Thu, 17 Dec 2020 10:50:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 1/8] ext4: Combine ext4_handle_error() and
 save_error_info()
Message-ID: <X9t+RK2jwTD5OfXH@mit.edu>
References: <20201216101844.22917-1-jack@suse.cz>
 <20201216101844.22917-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216101844.22917-2-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 16, 2020 at 11:18:37AM +0100, Jan Kara wrote:
> save_error_info() is always called together with ext4_handle_error().
> Combine them into a single call and move unconditional bits out of
> save_error_info() into ext4_handle_error().
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
