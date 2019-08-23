Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF79A5D1
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2019 04:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbfHWCxb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 22:53:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56266 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731416AbfHWCxa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Aug 2019 22:53:30 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7N2rI2G031623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 22:53:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4157C42049E; Thu, 22 Aug 2019 22:53:18 -0400 (EDT)
Date:   Thu, 22 Aug 2019 22:53:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rakesh Pandit <rakesh@tuxera.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix warning inside
 ext4_convert_unwritten_extents_endio
Message-ID: <20190823025318.GB8130@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Rakesh Pandit <rakesh@tuxera.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <20190814095406.GA38531@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814095406.GA38531@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 14, 2019 at 12:54:08PM +0300, Rakesh Pandit wrote:
> Really enable warning when CONFIG_EXT4_DEBUG is set and fix missing
> first argument.  This was introduced in commit ff95ec22cd7f ("ext4:
> add warning to ext4_convert_unwritten_extents_endio") and splitting
> extents inside endio would trigger it.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>

Thanks, applied.

					- Ted
