Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146401E7376
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391621AbgE2DKi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 23:10:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55051 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389625AbgE2DKh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 23:10:37 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04T3ARkg025243
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 23:10:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40186420304; Thu, 28 May 2020 23:10:27 -0400 (EDT)
Date:   Thu, 28 May 2020 23:10:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jonny Grant <jg@jguk.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: add comment for ext4_dir_entry_2 file_type member
Message-ID: <20200529031027.GJ228632@mit.edu>
References: <ad3290d5-86af-99c1-f9d5-cd1bab710429@jguk.org>
 <04681804-F540-48E9-BD4A-79AF89DBC6CA@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04681804-F540-48E9-BD4A-79AF89DBC6CA@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 22, 2020 at 11:12:41PM -0600, Andreas Dilger wrote:
> On May 22, 2020, at 9:09 AM, Jonny Grant <jg@jguk.org> wrote:
> > 
> > From 4e9d768a0adb60698ba13e7b7522c15a4548332a Mon Sep 17 00:00:00 2001
> > From: Jonathan Grant <jg@jguk.org>
> > Date: Fri, 22 May 2020 16:07:58 +0100
> > Subject: [PATCH] add comment for ext4_dir_entry_2 file_type member
> > 
> > Signed-off-by: Jonathan Grant <jg@jguk.org>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
