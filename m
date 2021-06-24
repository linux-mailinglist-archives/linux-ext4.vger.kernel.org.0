Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79FD3B312E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFXOZr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 10:25:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51496 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230008AbhFXOZq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 10:25:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OENFkU000768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:23:16 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1BB6315C3CD7; Thu, 24 Jun 2021 10:23:15 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:23:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 1/2] fs: ext4: Consolidate checks for resize of bigalloc
 into ext4_resize_begin
Message-ID: <YNSVUy/DTWdhzuci@mit.edu>
References: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 07, 2021 at 12:15:08PM -0700, Josh Triplett wrote:
> Two different places checked for attempts to resize a filesystem with
> the bigalloc feature. Move the check into ext4_resize_begin, which both
> places already call.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Applied, thanks.

					- Ted
