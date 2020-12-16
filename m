Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF72DBA05
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 05:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPEXH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 23:23:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33309 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725274AbgLPEXH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 23:23:07 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG4MJE0013956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:22:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17807420280; Tue, 15 Dec 2020 23:22:19 -0500 (EST)
Date:   Tue, 15 Dec 2020 23:22:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: add docs about fast commit idempotence
Message-ID: <X9mLez3ucPiNNYC0@mit.edu>
References: <20201119232822.1860882-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119232822.1860882-1-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 19, 2020 at 03:28:22PM -0800, Harshad Shirwadkar wrote:
> Fast commit on-disk format is designed such that the replay of these
> tags can be idempotent. This patch adds documentation in the code in
> form of comments and in form kernel docs that describes these
> characteristics. This patch also adds a TODO item needed to ensure
> kernel fast commit replay idempotence.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

					- Ted
