Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586F5353017
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBUDP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 16:03:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54369 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229647AbhDBUDL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 16:03:11 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132K36Ol028596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 16:03:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DEFED15C3ACE; Fri,  2 Apr 2021 16:03:05 -0400 (EDT)
Date:   Fri, 2 Apr 2021 16:03:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2image: add OPTIONS section to man page
Message-ID: <YGd4eRiwpjBsXMK7@mit.edu>
References: <20210309083508.30900-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309083508.30900-1-adilger@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 09, 2021 at 01:35:08AM -0700, Andreas Dilger wrote:
> Reorganize the e2image.8 man page so that the command-line options
> are listed in a dedicated OPTIONS section, rather than being
> interspersed among the text in the DESCRIPTION section.  Otherwise,
> it is difficult to determine which options are available, and to
> find where each option is described.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Applied, thanks.

					- Ted
