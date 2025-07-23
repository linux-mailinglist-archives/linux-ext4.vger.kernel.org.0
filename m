Return-Path: <linux-ext4+bounces-9166-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36BB0F660
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AB27BAE81
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC22FA652;
	Wed, 23 Jul 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajICN4Ku"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26F2FC3AE;
	Wed, 23 Jul 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282223; cv=none; b=u4kJay8qooVrDggfxeYOJkb13NlDjDjEYL39HF9tBGVlM8c9Y8rvalX7bfm7yvCWO8hKji+aSYd+EGPAhXHvvgx5h2Yjh9Ix7EAB/tGFOn3R7ufT+e9tA0EL0rR7n+w5bF04Aj7nmgZeE9v7QJ5NDNfBulQAeJ+ih5SxBGjOnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282223; c=relaxed/simple;
	bh=aZqQBj3Q0MLO38xOs+l/KAa78pTbHFsmu7NSuwSazTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJJSuHTkZYWBrLWdLod2HTBwsca+gfYdOeEZF5nTP3dsYdSrDzCm4P16K86l4jhNX9XGhrL+o4OSUDcmIb3xOkwaTNXGvigs93R0F3iwE4PzDNEj7YLuvVnIFge2CuYTI0BCXitm7YbCxMC3JdIk07IlrRDtBY7pbtwkG3Gw71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajICN4Ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA051C4CEF8;
	Wed, 23 Jul 2025 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282221;
	bh=aZqQBj3Q0MLO38xOs+l/KAa78pTbHFsmu7NSuwSazTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajICN4KuGGGlV0yyQlHAdIDFz8bj43GXCAH4ORyaBqwi6xArAHsIiJ/uP4vZcLTWY
	 eKKMBCIbM6URY8c1VsiZpUfbnt8SHn/EkX+mJQ0NEEptOnHPOycaM6l5Nsw38w9748
	 LHmZk5PZfoKKV7AZA6QLYKp6w/L8a/DFxmeJOaMFEQDoHKPLTTD6yjzMqWMJSDD5Vz
	 GdnIQ0yCpTVS6CguD86wWbYUafG+38CZM0WWl/+/A0sMrbXE6EhZ10VAp8sQ2aqi7a
	 SoCZtPkgAjw+KYRh1j0WJbois5N0yIKHDAFyZp8yQuszOv5Zvf6bxvB/Cs5VASLeoJ
	 pJcuzt8141LSg==
Date: Wed, 23 Jul 2025 07:50:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <20250723145021.GM2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <84a1820482419a1f1fb599bc35c2b7dcc1abbcb9.1752329098.git.ojaswin@linux.ibm.com>
 <20250717161154.GF2672039@frogsfrogsfrogs>
 <aH9ffl7-2ri2Exgv@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH9ffl7-2ri2Exgv@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Jul 22, 2025 at 03:23:02PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jul 17, 2025 at 09:11:54AM -0700, Darrick J. Wong wrote:
> > On Sat, Jul 12, 2025 at 07:42:44PM +0530, Ojaswin Mujoo wrote:
> > > Insert range and collapse range only works with bigalloc in case
> > > the range is cluster size aligned, which fsx doesnt take care. To
> > > work past this, disable insert range and collapse range on ext4, if
> > > bigalloc is enabled.
> > > 
> > > This is achieved by defining a new function _set_default_fsx_avoid
> > > called via run_fsx helper. This can be used to selectively disable
> > > fsx options based on the configuration.
> > > 
> > > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  common/rc | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 9a9d3cc8..218cf253 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5113,10 +5113,37 @@ _require_hugepage_fsx()
> > >  		_notrun "fsx binary does not support MADV_COLLAPSE"
> > >  }
> > >  
> > > +_set_default_fsx_avoid() {
> > > +	local file=$1
> > > +
> > > +	case "$FSTYP" in
> > > +	"ext4")
> > > +		local dev=$(findmnt -n -o SOURCE --target $file)
> > > +
> > > +		# open code instead of _require_dumpe2fs cause we don't
> > > +		# want to _notrun if dumpe2fs is not available
> > > +		if [ -z "$DUMPE2FS_PROG" ]; then
> > > +			echo "_set_default_fsx_avoid: dumpe2fs not found, skipping bigalloc check." >> $seqres.full
> > > +			return
> > > +		fi
> > 
> > I hate to be the guy who says one thing and then another, but ...
> > 
> > If we extended _get_file_block_size to report the ext4 bigalloc cluster
> > size, would that be sufficient to keep testing collapse/insert range?
> > 
> > I guess the tricky part here is that bigalloc allows sub-cluster
> > mappings and we might not want to do all file IO testing in such big
> > units.
> 
> Hmm, so maybe a better way is to just add a parameter like alloc_unit in
> fsx where we can pass the cluster_size to which INSERT/COLLAPSE range be
> aligned to. For now we can pass it explicitly in the tests if needed.
> 
> I do plan on working on your suggestion of exposing alloc unit via
> statx(). Once we have that in the kernel, fsx can use that as well.
> 
> If this approach sounds okay I can try to maybe send the whole "fixing
> of insert/collpase range in fsx" as a patchset separate from atomic
> writes.

Yeah, that sounds like a good longer-term solution to me. :)

--D

> > 
> > > +
> > > +		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
> > > +			export FSX_AVOID+=" -I -C"
> > 
> > No need to export FSX_AVOID to subprocesses.
> > 
> > --D
> 
> Got it, will fix. Thanks for review!
> 
> 
> Regards,
> ojaswin
> > 
> > > +		}
> > > +		;;
> > > +	# Add other filesystem types here as needed
> > > +	*)
> > > +		;;
> > > +	esac
> > > +}
> > > +
> > >  _run_fsx()
> > >  {
> > >  	echo "fsx $*"
> > >  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> > > +
> > > +	_set_default_fsx_avoid $testfile
> > > +
> > >  	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
> > >  	echo "$@" >>$seqres.full
> > >  	rm -f $TEST_DIR/junk
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 

