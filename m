Return-Path: <linux-ext4+bounces-9129-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1500B0B8EF
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 00:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09912168DBE
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Jul 2025 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B3422A7E6;
	Sun, 20 Jul 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRvrcn8c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C23226165
	for <linux-ext4@vger.kernel.org>; Sun, 20 Jul 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051322; cv=none; b=ukzSAIYnCQU6lFJuPKQJuEhjPOZVjgJWUz99wsJkTkOb/+DhrdQNx/xmxQb4tTh0FQxArNYuPhyHHa+3k840xg5f8XyouM4BUyVyG0FuxbqkqPW9XyD4NCmB+rsZ3XkUsSL3mwz44OqLbCLKq2EPaSwy1BsrBA6iQ+ksLrLRHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051322; c=relaxed/simple;
	bh=WQkqoOTIj3/vrhVBODEclxHKljDmiltuA8SDGRhilG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ5h0GvEjOP+V66qKlxcDuTZlCRZWhLSDmrqSwOa8hyhjIJcS3bb+pALYCfVaqzCmPh2hAujMLQatvCCrMbAfg5T539NNWb4hcF2qOjNYnW0DPvsoLcN0q1X+UvbnDfy2h0m4RYfBSkMCcs5AHTxY8dw8qKMvci15F9GNawOkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRvrcn8c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753051320; x=1784587320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WQkqoOTIj3/vrhVBODEclxHKljDmiltuA8SDGRhilG0=;
  b=VRvrcn8cPk/2UYy/RcWe/hg+jBW9VfKp9/HkoAW2Cl4e19qBlpiWu8/8
   aLm8ZQXIJC+mOKjJ4r9v0ggJAmCLhFdN0RYOGA6MLq/oyFjzi6IHGLVSq
   ESdW0jR4sz9rfrfiVFsQ6uRyDW+EwljyU5VI9OZyRBipO4ZznhAfGgS6N
   mMBt5MoqZM3YeKCA/ypbYGXTim57di9r5dtP4KEAsH9vmKl7MIXi4WtpR
   Vp+QZdvKMayMR/613gACL6LhX16ZDRVoR5skHs+2JeRh3CceFsrhD96wN
   FpQAA8ZlXm5BGGQRFrjTt/KSNlHoGOBLC0LBOf8+PkktDS2me07FPNII+
   g==;
X-CSE-ConnectionGUID: xCv1eL48SiyzwTSTYKUWuQ==
X-CSE-MsgGUID: 9CrzKSLaQGWkbDViX7vLXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="72832635"
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="72832635"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 15:42:00 -0700
X-CSE-ConnectionGUID: aSt6DniiRkGmCRh7V7Twng==
X-CSE-MsgGUID: bwAaaF6CRdmUlq+d8odIRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,327,1744095600"; 
   d="scan'208";a="159383743"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Jul 2025 15:41:58 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udcjD-000GLB-2d;
	Sun, 20 Jul 2025 22:41:55 +0000
Date: Mon, 21 Jul 2025 06:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Bretz <bretznic@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] ext4: clear extent index structure after file delete
Message-ID: <202507210558.sazSHcm1-lkp@intel.com>
References: <20250718122654.1431747-1-bretznic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718122654.1431747-1-bretznic@gmail.com>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.16-rc6 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Bretz/ext4-clear-extent-index-structure-after-file-delete/20250718-202802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20250718122654.1431747-1-bretznic%40gmail.com
patch subject: [PATCH v2] ext4: clear extent index structure after file delete
config: csky-randconfig-r121-20250720 (https://download.01.org/0day-ci/archive/20250721/202507210558.sazSHcm1-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250721/202507210558.sazSHcm1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507210558.sazSHcm1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ext4/extents.c:3065:55: sparse: sparse: restricted __le16 degrades to integer

vim +3065 fs/ext4/extents.c

  2818	
  2819	int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
  2820				  ext4_lblk_t end)
  2821	{
  2822		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
  2823		int depth = ext_depth(inode);
  2824		struct ext4_ext_path *path = NULL;
  2825		struct ext4_extent_idx *ix = NULL;
  2826		struct partial_cluster partial;
  2827		handle_t *handle;
  2828		int i = 0, err = 0;
  2829		int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
  2830	
  2831		partial.pclu = 0;
  2832		partial.lblk = 0;
  2833		partial.state = initial;
  2834	
  2835		ext_debug(inode, "truncate since %u to %u\n", start, end);
  2836	
  2837		/* probably first extent we're gonna free will be last in block */
  2838		handle = ext4_journal_start_with_revoke(inode, EXT4_HT_TRUNCATE,
  2839				depth + 1,
  2840				ext4_free_metadata_revoke_credits(inode->i_sb, depth));
  2841		if (IS_ERR(handle))
  2842			return PTR_ERR(handle);
  2843	
  2844	again:
  2845		trace_ext4_ext_remove_space(inode, start, end, depth);
  2846	
  2847		/*
  2848		 * Check if we are removing extents inside the extent tree. If that
  2849		 * is the case, we are going to punch a hole inside the extent tree
  2850		 * so we have to check whether we need to split the extent covering
  2851		 * the last block to remove so we can easily remove the part of it
  2852		 * in ext4_ext_rm_leaf().
  2853		 */
  2854		if (end < EXT_MAX_BLOCKS - 1) {
  2855			struct ext4_extent *ex;
  2856			ext4_lblk_t ee_block, ex_end, lblk;
  2857			ext4_fsblk_t pblk;
  2858	
  2859			/* find extent for or closest extent to this block */
  2860			path = ext4_find_extent(inode, end, NULL, flags);
  2861			if (IS_ERR(path)) {
  2862				ext4_journal_stop(handle);
  2863				return PTR_ERR(path);
  2864			}
  2865			depth = ext_depth(inode);
  2866			/* Leaf not may not exist only if inode has no blocks at all */
  2867			ex = path[depth].p_ext;
  2868			if (!ex) {
  2869				if (depth) {
  2870					EXT4_ERROR_INODE(inode,
  2871							 "path[%d].p_hdr == NULL",
  2872							 depth);
  2873					err = -EFSCORRUPTED;
  2874				}
  2875				goto out;
  2876			}
  2877	
  2878			ee_block = le32_to_cpu(ex->ee_block);
  2879			ex_end = ee_block + ext4_ext_get_actual_len(ex) - 1;
  2880	
  2881			/*
  2882			 * See if the last block is inside the extent, if so split
  2883			 * the extent at 'end' block so we can easily remove the
  2884			 * tail of the first part of the split extent in
  2885			 * ext4_ext_rm_leaf().
  2886			 */
  2887			if (end >= ee_block && end < ex_end) {
  2888	
  2889				/*
  2890				 * If we're going to split the extent, note that
  2891				 * the cluster containing the block after 'end' is
  2892				 * in use to avoid freeing it when removing blocks.
  2893				 */
  2894				if (sbi->s_cluster_ratio > 1) {
  2895					pblk = ext4_ext_pblock(ex) + end - ee_block + 1;
  2896					partial.pclu = EXT4_B2C(sbi, pblk);
  2897					partial.state = nofree;
  2898				}
  2899	
  2900				/*
  2901				 * Split the extent in two so that 'end' is the last
  2902				 * block in the first new extent. Also we should not
  2903				 * fail removing space due to ENOSPC so try to use
  2904				 * reserved block if that happens.
  2905				 */
  2906				path = ext4_force_split_extent_at(handle, inode, path,
  2907								  end + 1, 1);
  2908				if (IS_ERR(path)) {
  2909					err = PTR_ERR(path);
  2910					goto out;
  2911				}
  2912			} else if (sbi->s_cluster_ratio > 1 && end >= ex_end &&
  2913				   partial.state == initial) {
  2914				/*
  2915				 * If we're punching, there's an extent to the right.
  2916				 * If the partial cluster hasn't been set, set it to
  2917				 * that extent's first cluster and its state to nofree
  2918				 * so it won't be freed should it contain blocks to be
  2919				 * removed. If it's already set (tofree/nofree), we're
  2920				 * retrying and keep the original partial cluster info
  2921				 * so a cluster marked tofree as a result of earlier
  2922				 * extent removal is not lost.
  2923				 */
  2924				lblk = ex_end + 1;
  2925				err = ext4_ext_search_right(inode, path, &lblk, &pblk,
  2926							    NULL, flags);
  2927				if (err < 0)
  2928					goto out;
  2929				if (pblk) {
  2930					partial.pclu = EXT4_B2C(sbi, pblk);
  2931					partial.state = nofree;
  2932				}
  2933			}
  2934		}
  2935		/*
  2936		 * We start scanning from right side, freeing all the blocks
  2937		 * after i_size and walking into the tree depth-wise.
  2938		 */
  2939		depth = ext_depth(inode);
  2940		if (path) {
  2941			int k = i = depth;
  2942			while (--k > 0)
  2943				path[k].p_block =
  2944					le16_to_cpu(path[k].p_hdr->eh_entries)+1;
  2945		} else {
  2946			path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
  2947				       GFP_NOFS | __GFP_NOFAIL);
  2948			if (path == NULL) {
  2949				ext4_journal_stop(handle);
  2950				return -ENOMEM;
  2951			}
  2952			path[0].p_maxdepth = path[0].p_depth = depth;
  2953			path[0].p_hdr = ext_inode_hdr(inode);
  2954			i = 0;
  2955	
  2956			if (ext4_ext_check(inode, path[0].p_hdr, depth, 0)) {
  2957				err = -EFSCORRUPTED;
  2958				goto out;
  2959			}
  2960		}
  2961		err = 0;
  2962	
  2963		while (i >= 0 && err == 0) {
  2964			if (i == depth) {
  2965				/* this is leaf block */
  2966				err = ext4_ext_rm_leaf(handle, inode, path,
  2967						       &partial, start, end);
  2968				/* root level has p_bh == NULL, brelse() eats this */
  2969				ext4_ext_path_brelse(path + i);
  2970				i--;
  2971				continue;
  2972			}
  2973	
  2974			/* this is index block */
  2975			if (!path[i].p_hdr) {
  2976				ext_debug(inode, "initialize header\n");
  2977				path[i].p_hdr = ext_block_hdr(path[i].p_bh);
  2978			}
  2979	
  2980			if (!path[i].p_idx) {
  2981				/* this level hasn't been touched yet */
  2982				path[i].p_idx = EXT_LAST_INDEX(path[i].p_hdr);
  2983				path[i].p_block = le16_to_cpu(path[i].p_hdr->eh_entries)+1;
  2984				ext_debug(inode, "init index ptr: hdr 0x%p, num %d\n",
  2985					  path[i].p_hdr,
  2986					  le16_to_cpu(path[i].p_hdr->eh_entries));
  2987			} else {
  2988				/* we were already here, see at next index */
  2989				path[i].p_idx--;
  2990			}
  2991	
  2992			ext_debug(inode, "level %d - index, first 0x%p, cur 0x%p\n",
  2993					i, EXT_FIRST_INDEX(path[i].p_hdr),
  2994					path[i].p_idx);
  2995			if (ext4_ext_more_to_rm(path + i)) {
  2996				struct buffer_head *bh;
  2997				/* go to the next level */
  2998				ext_debug(inode, "move to level %d (block %llu)\n",
  2999					  i + 1, ext4_idx_pblock(path[i].p_idx));
  3000				memset(path + i + 1, 0, sizeof(*path));
  3001				bh = read_extent_tree_block(inode, path[i].p_idx,
  3002							    depth - i - 1, flags);
  3003				if (IS_ERR(bh)) {
  3004					/* should we reset i_size? */
  3005					err = PTR_ERR(bh);
  3006					break;
  3007				}
  3008				/* Yield here to deal with large extent trees.
  3009				 * Should be a no-op if we did IO above. */
  3010				cond_resched();
  3011				if (WARN_ON(i + 1 > depth)) {
  3012					err = -EFSCORRUPTED;
  3013					break;
  3014				}
  3015				path[i + 1].p_bh = bh;
  3016	
  3017				/* save actual number of indexes since this
  3018				 * number is changed at the next iteration */
  3019				path[i].p_block = le16_to_cpu(path[i].p_hdr->eh_entries);
  3020				i++;
  3021			} else {
  3022				/* we finished processing this index, go up */
  3023				if (path[i].p_hdr->eh_entries == 0 && i > 0) {
  3024					/* index is empty, remove it;
  3025					 * handle must be already prepared by the
  3026					 * truncatei_leaf() */
  3027					err = ext4_ext_rm_idx(handle, inode, path, i);
  3028				}
  3029				/* root level has p_bh == NULL, brelse() eats this */
  3030				ext4_ext_path_brelse(path + i);
  3031				i--;
  3032				ext_debug(inode, "return to level %d\n", i);
  3033			}
  3034		}
  3035	
  3036		trace_ext4_ext_remove_space_done(inode, start, end, depth, &partial,
  3037						 path->p_hdr->eh_entries);
  3038	
  3039		/*
  3040		 * if there's a partial cluster and we have removed the first extent
  3041		 * in the file, then we also free the partial cluster, if any
  3042		 */
  3043		if (partial.state == tofree && err == 0) {
  3044			int flags = get_default_free_blocks_flags(inode);
  3045	
  3046			if (ext4_is_pending(inode, partial.lblk))
  3047				flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
  3048			ext4_free_blocks(handle, inode, NULL,
  3049					 EXT4_C2B(sbi, partial.pclu),
  3050					 sbi->s_cluster_ratio, flags);
  3051			if (flags & EXT4_FREE_BLOCKS_RERESERVE_CLUSTER)
  3052				ext4_rereserve_cluster(inode, partial.lblk);
  3053			partial.state = initial;
  3054		}
  3055	
  3056		/* TODO: flexible tree reduction should be here */
  3057		if (path->p_hdr->eh_entries == 0) {
  3058			/*
  3059			 * truncate to zero freed all the tree,
  3060			 * so we need to correct eh_depth
  3061			 */
  3062			err = ext4_ext_get_access(handle, inode, path);
  3063			if (err == 0) {
  3064				ix = EXT_FIRST_INDEX(path->p_hdr);
> 3065				if (ix && ext_inode_hdr(inode)->eh_depth > 0)
  3066					ext4_idx_store_pblock(ix, 0);
  3067				ext_inode_hdr(inode)->eh_depth = 0;
  3068				ext_inode_hdr(inode)->eh_max =
  3069					cpu_to_le16(ext4_ext_space_root(inode, 0));
  3070				err = ext4_ext_dirty(handle, inode, path);
  3071			}
  3072		}
  3073	out:
  3074		ext4_free_ext_path(path);
  3075		path = NULL;
  3076		if (err == -EAGAIN)
  3077			goto again;
  3078		ext4_journal_stop(handle);
  3079	
  3080		return err;
  3081	}
  3082	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

