Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63F2DBA56
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgLPFMK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:12:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40621 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725274AbgLPFMK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Dec 2020 00:12:10 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG5BLwo032114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:11:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 36816420280; Wed, 16 Dec 2020 00:11:21 -0500 (EST)
Date:   Wed, 16 Dec 2020 00:11:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/12] ext4: Simplify ext4 error translation
Message-ID: <X9mW+ffKW3KgKS0p@mit.edu>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127113405.26867-7-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 27, 2020 at 12:33:59PM +0100, Jan Kara wrote:
> We convert errno's to ext4 on-disk format error codes in
> save_error_info(). Add a function and a bit of macro magic to make this
> simpler.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

				- Ted
