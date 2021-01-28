Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745FF306B7F
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jan 2021 04:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhA1DSX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 22:18:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42581 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229528AbhA1DSS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 22:18:18 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10S3HQ3t024049
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 22:17:27 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 627A515C344F; Wed, 27 Jan 2021 22:17:26 -0500 (EST)
Date:   Wed, 27 Jan 2021 22:17:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org, drosen@google.com,
        krisman@collabora.com, ebiggers@kernel.org
Subject: Re: [PATCH v3 09/12] e2fsck: Detect duplicated casefolded direntries
 for rehash
Message-ID: <YBIsxmqravwnFXRt@mit.edu>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
 <20201217173544.52953-10-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217173544.52953-10-arnaud.ferraris@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 17, 2020 at 06:35:41PM +0100, Arnaud Ferraris wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> On pass2, support casefolded directories when looking for duplicated
> entries.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Thanks, applied.

					- Ted
