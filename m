Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930AC34F7E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2019 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFDSCx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jun 2019 14:02:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32985 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726200AbfFDSCx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jun 2019 14:02:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x54I2gtG020816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jun 2019 14:02:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 78C90420481; Tue,  4 Jun 2019 14:02:37 -0400 (EDT)
Date:   Tue, 4 Jun 2019 14:02:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2scrub: remove -C from e2scrub_all
Message-ID: <20190604180237.GA3231@mit.edu>
References: <20190604042712.GB5378@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604042712.GB5378@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 03, 2019 at 09:27:12PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> We already have the "SERVICE_MODE=1" feature that signals to e2scrub
> that we're running as a background daemon and therefore we should exit
> quietly if conditions aren't right.
> 
> It's therefore unnecessary to have a separate -C flag to achieve the
> same outcome for cron jobs.  Merge the two together.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks, applied.

						- Ted
