Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64FA2325F1
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG2UMo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 16:12:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51363 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726884AbgG2UMn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 16:12:43 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06TKCbZx023499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 16:12:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 41997420304; Wed, 29 Jul 2020 16:12:37 -0400 (EDT)
Date:   Wed, 29 Jul 2020 16:12:37 -0400
From:   tytso@mit.edu
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix spelling mistakes in extents.c
Message-ID: <20200729201237.GB44720@mit.edu>
References: <20200611031947.165079-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611031947.165079-1-iamkeyur96@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 10, 2020 at 11:19:46PM -0400, Keyur Patel wrote:
> Fix spelling issues over the comments in the code.
> 
> requsted ==> requested
> deterimined ==> determined
> insde ==> inside
> neet ==> need
> somthing ==> something
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>

Applied, thanks.

						- Ted
