Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0D4364E4
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Oct 2021 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJUPCX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Oct 2021 11:02:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60623 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230331AbhJUPCX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Oct 2021 11:02:23 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19LExhHt028260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 10:59:46 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B33E815C00CE; Thu, 21 Oct 2021 10:59:43 -0400 (EDT)
Date:   Thu, 21 Oct 2021 10:59:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH 0/3] ext4: enhance extent consistency check
Message-ID: <YXGAX0HpHZx8Smip@mit.edu>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908120850.4012324-1-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, I've applied this patch series.  You're right, we are always
updating the index node.  There is a comment that we might try to skip
updating the index in some cases, but it's probably better to always
update the index node since we can count on knowing what logical
blocks could be mentioned in the leaf nodes.

       	     		     	      - Ted
