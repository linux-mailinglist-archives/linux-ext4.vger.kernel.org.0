Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24873E7B96
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbhHJPCI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 11:02:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57306 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240809AbhHJPCH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 11:02:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17AF1fFC016870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 11:01:42 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CC91D15C3DD0; Tue, 10 Aug 2021 11:01:41 -0400 (EDT)
Date:   Tue, 10 Aug 2021 11:01:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/7] e2fsprogs: remove augmented rbtree functionality
Message-ID: <YRKU1ff6k8fiAhep@mit.edu>
References: <20210806095820.83731-1-lczerner@redhat.com>
 <20210806095820.83731-4-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806095820.83731-4-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 06, 2021 at 11:58:17AM +0200, Lukas Czerner wrote:
> Rbtree code was originally taken from linux kernel. This includes the
> augmented rbtree functionality, however this was never intended to be
> used and is not used still. Just remove it.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Applied, thanks.

					- Ted
