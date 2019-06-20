Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE94C606
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 06:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFTEMK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 00:12:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47094 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbfFTEMK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 00:12:10 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5K4C5O4008236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 00:12:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17899420484; Thu, 20 Jun 2019 00:12:05 -0400 (EDT)
Date:   Thu, 20 Jun 2019 00:12:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove redundant assignment to node
Message-ID: <20190620041204.GC15783@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Colin King <colin.king@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190619090007.26962-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090007.26962-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 19, 2019 at 10:00:06AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'node' is assigned a value that is never read, node is
> later overwritten when it re-assigned a different value inside
> the while-loop.  The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.

						- Ted
