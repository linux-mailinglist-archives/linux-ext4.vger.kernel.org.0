Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612C3249100
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 00:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHRWhE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 18:37:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34929 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgHRWhE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 18:37:04 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IMawIK020543
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 18:36:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 24899420DC0; Tue, 18 Aug 2020 18:36:58 -0400 (EDT)
Date:   Tue, 18 Aug 2020 18:36:58 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     kyoungho koo <rnrudgh@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix comment typo "the the".
Message-ID: <20200818223658.GD162457@mit.edu>
References: <20200424171620.GA11943@koo-Z370-HD3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424171620.GA11943@koo-Z370-HD3>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 25, 2020 at 02:16:24AM +0900, kyoungho koo wrote:
> I have found double typed comments "the the". So i modified it to
> one "the"
> 
> Signed-off-by: kyoungho koo <rnrudgh@gmail.com>

Thanks, applied; apologies for this falling through the cracks!

		 	       	    - Ted
