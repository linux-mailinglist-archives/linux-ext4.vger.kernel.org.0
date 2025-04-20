Return-Path: <linux-ext4+bounces-7343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C6AA94699
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Apr 2025 05:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622A4174E57
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Apr 2025 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9C157A6C;
	Sun, 20 Apr 2025 03:39:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16FF33062
	for <linux-ext4@vger.kernel.org>; Sun, 20 Apr 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745120378; cv=none; b=DMEsN2RRFm5f6WNj0OATRtq3eT6V5w4FEyLuECWpfI1hnVSiVvyISIEL3F1WEKT/VaijEOlKi4JuqkJNK/q/1gyqWJl3V1qRKU6qZmaCQaIoYkGXQ8k1J6N1u7NC7Up712Xa9g2AzIQ7InnAtkfBOMkQnBdJr3uVIqy9MtAtpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745120378; c=relaxed/simple;
	bh=LjXSFinQaL8Q0L8B7IJY6YZ6UHGOzWv38ilPpbfp9YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tni/VvcV40hqSiRwncWxOfckLsCL190KSKh2GLWINccIeo57vRa/up5sS8DJklweu+SJETKzsorBY6CR7nsNR9XI7SXcSqe7pnWM6mzehghJb7oCOYC0al5MeLa/vbz+H66KTTy33NH2OThvEgcie6WXwbPTpIZxYGe6+GOpQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53K3dIAY022339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 23:39:20 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7229F3458E4; Sat, 19 Apr 2025 22:39:18 -0500 (CDT)
Date: Sat, 19 Apr 2025 22:39:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250420033918.GE210438@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417164907.GA6008@mit.edu>
 <aAFmDjDtZBzxiN66@bombadil.infradead.org>
 <aAGuAYGZfpUSabSf@bombadil.infradead.org>
 <20250418035623.GC6008@mit.edu>
 <aAKjIUbRYH8h4FnE@bombadil.infradead.org>
 <20250419183641.GD210438@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419183641.GD210438@mit.edu>

On Sat, Apr 19, 2025 at 01:36:41PM -0500, Theodore Ts'o wrote:
> 
> Quite a few years ago, the upstream xfstests-bld maintainer at the
> time was very much against adding these sorts of exceptions.

Typo, this should have read, "Quite a few years ago, the upstream
XFSTESTS maintainer at the time...."

Again, if someone would like to work with trying to get changes
upstream so we don't need as much of an exclude file, help would
certainly be appreciated.  Or we can just keep using an exclude file.
Whatever.

                                        - Ted

