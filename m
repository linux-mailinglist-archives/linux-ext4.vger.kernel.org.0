Return-Path: <linux-ext4+bounces-14478-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK6QAfl8pmnDQQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14478-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 07:17:29 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB21E9874
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 07:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B9E930255D9
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E7382289;
	Tue,  3 Mar 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc9DDdd4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66E37B01B;
	Tue,  3 Mar 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518639; cv=none; b=dV746hww89kiyedGD683ED2jQzwodMP+VKc3SNytZsol4kyhvK239sHlcGGRmU3T/K4sA5KxaSVfwNgg3M6MnryrPvO9dFwh4xvi+9AeiuwVXfEXqpd+VbsNMwKt4fQN8dXlvFO+gYPXJ+rg5cdZW9qvpecKUfWzY1AuMTuZHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518639; c=relaxed/simple;
	bh=ka6eL33Jt9I35ApjzE1CrM6M3nQb1iZZQV/GPTd4NfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckCrPb+4j7KMyPyBKH8v0SZPmrVG/tYeAZ9f3Yn7q+bCw5fs7E9tqiNagFNUc7ZxD/GdMNXQft6em6s+AWaAdIT/GTMR+mh7NGxxRhcRDpDv0RHRZZpfYlm4N1XDmD+iS+q0sw4tyhLr7AI8KuXLGaOIKzLDaq3D2+bH7sPfAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc9DDdd4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772518636; x=1804054636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ka6eL33Jt9I35ApjzE1CrM6M3nQb1iZZQV/GPTd4NfU=;
  b=Yc9DDdd4BL881fmou8guMZOdfNkJLK1AMexJEjpY0E3ACgNYXqxxT3gJ
   XKSQrBWl+sxIVUOrptSJ2AfSbZpVpDXpmIfDQOverxxgjZGl/Lbjc2riT
   CH0dYcQGBot0ot+T4ERINTax27SvNq1csQU9tZ0O5WUn3tDA9x/Ips4ej
   lYCbay3y9dip6mxiSwZcdaB6I4Br08D7rndJXRizF1EjSaEcz+BXHjpaC
   8Umee6sw61qqG3QlsnJqRikTo6ezca0ifBkvbkT7wgtANzuO4pytB8uQz
   t71AtPnKKh6sOvLaOwprnPA3qyH8Z8sebmVk3XSs51DM7q+fegsylFOdn
   Q==;
X-CSE-ConnectionGUID: TePF3rc9QxuTfbMD6VY4nQ==
X-CSE-MsgGUID: 8tB96LSMQ1+z/gH29lnOAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="83881523"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="83881523"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 22:17:15 -0800
X-CSE-ConnectionGUID: gYofQhR5TsqGfn2cm4Ys0A==
X-CSE-MsgGUID: sMnBYowSRkqWoGUCHV3PJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="222056905"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 02 Mar 2026 22:17:14 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxJ4B-000000001Nx-1dxo;
	Tue, 03 Mar 2026 06:17:11 +0000
Date: Tue, 3 Mar 2026 07:16:52 +0100
From: kernel test robot <lkp@intel.com>
To: Milos Nikic <nikic.milos@gmail.com>, jack@suse.cz
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: Re: [PATCH v3 2/2] jbd2: gracefully abort on transaction state
 corruptions
Message-ID: <202603030706.NpyA7pqe-lkp@intel.com>
References: <20260303005502.337108-3-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303005502.337108-3-nikic.milos@gmail.com>
X-Rspamd-Queue-Id: C3CB21E9874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,mit.edu,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14478-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Action: no action

Hi Milos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on tytso-ext4/dev next-20260302]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Milos-Nikic/jbd2-gracefully-abort-instead-of-panicking-on-unlocked-buffer/20260303-085946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260303005502.337108-3-nikic.milos%40gmail.com
patch subject: [PATCH v3 2/2] jbd2: gracefully abort on transaction state corruptions
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260303/202603030706.NpyA7pqe-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260303/202603030706.NpyA7pqe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603030706.NpyA7pqe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/jbd2/transaction.c:1547:11: warning: variable 'journal' is uninitialized when used here [-Wuninitialized]
    1547 |                                journal->j_devname, jh->b_transaction,
         |                                ^~~~~~~
   include/linux/printk.h:554:33: note: expanded from macro 'pr_err'
     554 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/printk.h:511:60: note: expanded from macro 'printk'
     511 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:483:19: note: expanded from macro 'printk_index_wrap'
     483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   fs/jbd2/transaction.c:1520:20: note: initialize the variable 'journal' to silence this warning
    1520 |         journal_t *journal;
         |                           ^
         |                            = NULL
   1 warning generated.


vim +/journal +1547 fs/jbd2/transaction.c

  1493	
  1494	/**
  1495	 * jbd2_journal_dirty_metadata() -  mark a buffer as containing dirty metadata
  1496	 * @handle: transaction to add buffer to.
  1497	 * @bh: buffer to mark
  1498	 *
  1499	 * mark dirty metadata which needs to be journaled as part of the current
  1500	 * transaction.
  1501	 *
  1502	 * The buffer must have previously had jbd2_journal_get_write_access()
  1503	 * called so that it has a valid journal_head attached to the buffer
  1504	 * head.
  1505	 *
  1506	 * The buffer is placed on the transaction's metadata list and is marked
  1507	 * as belonging to the transaction.
  1508	 *
  1509	 * Returns error number or 0 on success.
  1510	 *
  1511	 * Special care needs to be taken if the buffer already belongs to the
  1512	 * current committing transaction (in which case we should have frozen
  1513	 * data present for that commit).  In that case, we don't relink the
  1514	 * buffer: that only gets done when the old transaction finally
  1515	 * completes its commit.
  1516	 */
  1517	int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
  1518	{
  1519		transaction_t *transaction = handle->h_transaction;
  1520		journal_t *journal;
  1521		struct journal_head *jh;
  1522		int ret = 0;
  1523	
  1524		if (!buffer_jbd(bh))
  1525			return -EUCLEAN;
  1526	
  1527		/*
  1528		 * We don't grab jh reference here since the buffer must be part
  1529		 * of the running transaction.
  1530		 */
  1531		jh = bh2jh(bh);
  1532		jbd2_debug(5, "journal_head %p\n", jh);
  1533		JBUFFER_TRACE(jh, "entry");
  1534	
  1535		/*
  1536		 * This and the following assertions are unreliable since we may see jh
  1537		 * in inconsistent state unless we grab bh_state lock. But this is
  1538		 * crucial to catch bugs so let's do a reliable check until the
  1539		 * lockless handling is fully proven.
  1540		 */
  1541		if (data_race(jh->b_transaction != transaction &&
  1542		    jh->b_next_transaction != transaction)) {
  1543			spin_lock(&jh->b_state_lock);
  1544			if (WARN_ON_ONCE(jh->b_transaction != transaction &&
  1545					 jh->b_next_transaction != transaction)) {
  1546				pr_err("JBD2: %s: assertion failure: b_transaction=%p transaction=%p b_next_transaction=%p\n",
> 1547				       journal->j_devname, jh->b_transaction,
  1548				       transaction, jh->b_next_transaction);
  1549				ret = -EINVAL;
  1550				goto out_unlock_bh;
  1551			}
  1552			spin_unlock(&jh->b_state_lock);
  1553		}
  1554		if (data_race(jh->b_modified == 1)) {
  1555			/* If it's in our transaction it must be in BJ_Metadata list. */
  1556			if (data_race(jh->b_transaction == transaction &&
  1557			    jh->b_jlist != BJ_Metadata)) {
  1558				spin_lock(&jh->b_state_lock);
  1559				if (jh->b_transaction == transaction &&
  1560				    jh->b_jlist != BJ_Metadata)
  1561					pr_err("JBD2: assertion failure: h_type=%u h_line_no=%u block_no=%llu jlist=%u\n",
  1562					       handle->h_type, handle->h_line_no,
  1563					       (unsigned long long) bh->b_blocknr,
  1564					       jh->b_jlist);
  1565				if (WARN_ON_ONCE(jh->b_transaction == transaction &&
  1566						 jh->b_jlist != BJ_Metadata)) {
  1567					ret = -EINVAL;
  1568					goto out_unlock_bh;
  1569				}
  1570				spin_unlock(&jh->b_state_lock);
  1571			}
  1572			goto out;
  1573		}
  1574	
  1575		spin_lock(&jh->b_state_lock);
  1576	
  1577		if (is_handle_aborted(handle)) {
  1578			/*
  1579			 * Check journal aborting with @jh->b_state_lock locked,
  1580			 * since 'jh->b_transaction' could be replaced with
  1581			 * 'jh->b_next_transaction' during old transaction
  1582			 * committing if journal aborted, which may fail
  1583			 * assertion on 'jh->b_frozen_data == NULL'.
  1584			 */
  1585			ret = -EROFS;
  1586			goto out_unlock_bh;
  1587		}
  1588	
  1589		journal = transaction->t_journal;
  1590	
  1591		if (jh->b_modified == 0) {
  1592			/*
  1593			 * This buffer's got modified and becoming part
  1594			 * of the transaction. This needs to be done
  1595			 * once a transaction -bzzz
  1596			 */
  1597			if (WARN_ON_ONCE(jbd2_handle_buffer_credits(handle) <= 0)) {
  1598				ret = -ENOSPC;
  1599				goto out_unlock_bh;
  1600			}
  1601			jh->b_modified = 1;
  1602			handle->h_total_credits--;
  1603		}
  1604	
  1605		/*
  1606		 * fastpath, to avoid expensive locking.  If this buffer is already
  1607		 * on the running transaction's metadata list there is nothing to do.
  1608		 * Nobody can take it off again because there is a handle open.
  1609		 * I _think_ we're OK here with SMP barriers - a mistaken decision will
  1610		 * result in this test being false, so we go in and take the locks.
  1611		 */
  1612		if (jh->b_transaction == transaction && jh->b_jlist == BJ_Metadata) {
  1613			JBUFFER_TRACE(jh, "fastpath");
  1614			if (unlikely(jh->b_transaction !=
  1615				     journal->j_running_transaction)) {
  1616				printk(KERN_ERR "JBD2: %s: "
  1617				       "jh->b_transaction (%llu, %p, %u) != "
  1618				       "journal->j_running_transaction (%p, %u)\n",
  1619				       journal->j_devname,
  1620				       (unsigned long long) bh->b_blocknr,
  1621				       jh->b_transaction,
  1622				       jh->b_transaction ? jh->b_transaction->t_tid : 0,
  1623				       journal->j_running_transaction,
  1624				       journal->j_running_transaction ?
  1625				       journal->j_running_transaction->t_tid : 0);
  1626				ret = -EINVAL;
  1627			}
  1628			goto out_unlock_bh;
  1629		}
  1630	
  1631		set_buffer_jbddirty(bh);
  1632	
  1633		/*
  1634		 * Metadata already on the current transaction list doesn't
  1635		 * need to be filed.  Metadata on another transaction's list must
  1636		 * be committing, and will be refiled once the commit completes:
  1637		 * leave it alone for now.
  1638		 */
  1639		if (jh->b_transaction != transaction) {
  1640			JBUFFER_TRACE(jh, "already on other transaction");
  1641			if (unlikely(((jh->b_transaction !=
  1642				       journal->j_committing_transaction)) ||
  1643				     (jh->b_next_transaction != transaction))) {
  1644				printk(KERN_ERR "jbd2_journal_dirty_metadata: %s: "
  1645				       "bad jh for block %llu: "
  1646				       "transaction (%p, %u), "
  1647				       "jh->b_transaction (%p, %u), "
  1648				       "jh->b_next_transaction (%p, %u), jlist %u\n",
  1649				       journal->j_devname,
  1650				       (unsigned long long) bh->b_blocknr,
  1651				       transaction, transaction->t_tid,
  1652				       jh->b_transaction,
  1653				       jh->b_transaction ?
  1654				       jh->b_transaction->t_tid : 0,
  1655				       jh->b_next_transaction,
  1656				       jh->b_next_transaction ?
  1657				       jh->b_next_transaction->t_tid : 0,
  1658				       jh->b_jlist);
  1659				WARN_ON(1);
  1660				ret = -EINVAL;
  1661			}
  1662			/* And this case is illegal: we can't reuse another
  1663			 * transaction's data buffer, ever. */
  1664			goto out_unlock_bh;
  1665		}
  1666	
  1667		/* That test should have eliminated the following case: */
  1668		if (WARN_ON_ONCE(jh->b_frozen_data)) {
  1669			ret = -EINVAL;
  1670			goto out_unlock_bh;
  1671		}
  1672	
  1673		JBUFFER_TRACE(jh, "file as BJ_Metadata");
  1674		spin_lock(&journal->j_list_lock);
  1675		__jbd2_journal_file_buffer(jh, transaction, BJ_Metadata);
  1676		spin_unlock(&journal->j_list_lock);
  1677	out_unlock_bh:
  1678		spin_unlock(&jh->b_state_lock);
  1679	out:
  1680		JBUFFER_TRACE(jh, "exit");
  1681		return ret;
  1682	}
  1683	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

