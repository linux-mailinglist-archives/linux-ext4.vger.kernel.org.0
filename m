Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF630D2BE
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 06:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBCFGU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 00:06:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42540 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbhBCFGT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 00:06:19 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11355O9M011510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Feb 2021 00:05:24 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0188915C39E2; Wed,  3 Feb 2021 00:05:23 -0500 (EST)
Date:   Wed, 3 Feb 2021 00:05:23 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: Change list_for_each* to list_for_each_entry*
Message-ID: <YBovEwunfCV23Rxe@mit.edu>
References: <CGME20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7@epcms2p4>
 <20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111013726epcms2p4579ae56040d7043db785bf0d0a785dc7@epcms2p4>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 11, 2021 at 10:37:26AM +0900, Daejun Park wrote:
> In the fast_commit.c, list_for_each* + list_entry can be changed to
> list_for_each_entry*. It reduces number of variables and lines.
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Thanks, applied.

					- Ted
