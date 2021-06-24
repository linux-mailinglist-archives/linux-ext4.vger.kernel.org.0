Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7BF3B33E3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhFXQ07 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 12:26:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42088 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229721AbhFXQ06 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 12:26:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OGOYEs020085
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 12:24:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D34CE15C3CD7; Thu, 24 Jun 2021 12:24:33 -0400 (EDT)
Date:   Thu, 24 Jun 2021 12:24:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jonathan Davies <jonathan.davies@nutanix.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: notify sysfs on errors_count value change
Message-ID: <YNSxwR2GkUd6Dz9B@mit.edu>
References: <20210611140209.28903-1-jonathan.davies@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611140209.28903-1-jonathan.davies@nutanix.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 11, 2021 at 02:02:08PM +0000, Jonathan Davies wrote:
> After s_error_count is incremented, signal the change in the
> corresponding sysfs attribute via sysfs_notify. This allows userspace to
> poll() on changes to /sys/fs/ext4/*/errors_count.
> 
> Signed-off-by: Jonathan Davies <jonathan.davies@nutanix.com>

Applied, thanks.

					- Ted
